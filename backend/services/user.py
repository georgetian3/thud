import pathlib
import schemas.user
from schemas.base import ID
from passlib.hash import argon2
from datetime import datetime, timedelta
from models.base import *
import models.db
import models.user
import models.content
from enum import Enum
import secrets
from utils.emailsender import send_html_email
from services.notifications import NotificationService

Verification = Enum('Verification', ['NONE', 'EMAIL', 'TSINGHUA'])

class UserService:

    def __init__(self, config, db: models.db.Database, notification_service: NotificationService):
        self.config = config
        self.db = db
        self.notification_service = notification_service
        self.data_dir = pathlib.Path(config['data_dir'])

    # returns:
    #   None: invalid credentials
    #   ID: valid credentials
    async def authenticate(self, id_or_username: ID | str, password: str) -> ID | None:
        if isinstance(id_or_username, ID):
            stmt = select(models.user.User).where(models.user.User.id == id_or_username)
        elif isinstance(id_or_username, str):
            stmt = select(models.user.User).where(models.user.User.username == id_or_username)
        else:
            return None
        
        async with self.db.get_session() as session:
            user = await session.scalar(stmt)
        if user is None or not argon2.verify(password, user.password_hash):
            return None
        return user.id
    
    async def change_username(self, user_id: ID, new_username: str) -> bool:
        stmt = (
            update(models.user.User)
            .where(models.user.User.id == user_id)
            .values(username=new_username)
        )
                    
        async with self.db.get_session() as session:
            try:
                await session.execute(stmt)
                await session.commit()
                return True
            except:
                return False
    
    async def change_password(self, user_id: ID, old_password: str, new_password: str) -> bool:
        if await self.authenticate(user_id, old_password) is None:
            return False
        stmt = (
            update(models.user.User)
            .where(models.user.User.id == user_id)
            .values(password_hash=argon2.hash(new_password))
        )
                    
        async with self.db.get_session() as session:
            try:
                await session.execute(stmt)
                await session.commit()
                return True
            except:
                return False

    def media_id_to_path(self, media_id: ID) -> pathlib.Path:
        return self.data_dir / str(media_id)
    
    async def change_profile_picture(self, user_id: ID) -> tuple[ID, pathlib.Path]:
        user = await self.get_user(id=user_id)
        if user is None:
            return False
        if user.profile_picture is None:
            async with self.db.get_session() as session:
                media = models.content.Media()
                session.add(media)
                await session.commit()
                await session.refresh(media)
                media_id = media.media
                stmt = (
                    update(models.user.User)
                    .where(models.user.User.id == user_id)
                    .values(profile_picture=media_id)
                )
                await session.execute(stmt)
                await session.commit()
        else:
            media_id = user.profile_picture
        return media_id, self.media_id_to_path(media_id)
    
    async def change_bio(self, user_id: ID, bio: str):
        stmt = (
            update(models.user.User)
            .where(models.user.User.id == user_id)
            .values(bio=bio)
        )

        async with self.db.get_session() as session:
            await session.execute(stmt)
            await session.commit()

    async def verify_user(self, token: str):
        pass

    async def availability(self, username: schemas.user.Username=None, email: schemas.user.Email=None) -> dict:
        res = {}
        async with self.db.get_session() as session:
            if username:
                res['username'] = bool((await session.execute(
                    select(models.user.User).where(models.user.User.username == username)
                )).scalar())
            if email:
                res['email'] = bool((await session.execute(
                    select(models.user.User).where(models.user.User.email == email)
                )).scalar())
        return res
        
    async def create_user(self, register_info: schemas.user.RegisterRequest) -> schemas.user.User | None:

        user = models.user.User(
            username=register_info.username,
            password_hash=argon2.hash(register_info.password),
            date_joined=datetime.utcnow(),
            bio='[{"insert":"\\n"}]',
        )

        # delete_expired = delete(models.user.User).where(
        #     models.user.User.verification == 0 and
        #     models.user.User.id in select(models.user.VerificationToken).where(
        #         models.user.VerificationToken.expires >= datetime.utcnow()
        #     )
        # )

        # token = secrets.token_urlsafe(64)

        # print(delete_expired)

        async with self.db.get_session() as session:
            # delete expired account creation requests
            # await session.execute(delete_expired)
            # await session.commit()

            session.add(user)
            try:
                await session.commit()
            except IntegrityError as e:
                return None
                # return await self.availability(
                #     register_info.username,
                # )
                #duplicate_field = str(e.orig).rsplit('.', 1)[1]
                #return duplicate_field
            await session.refresh(user)
            # session.add(models.user.VerificationToken(
            #     user_id=user.id,
            #     token=token,
            #     expires=datetime.utcnow() + timedelta(minutes=15)
            # ))

            # await session.commit()

        # resp = await send_html_email(
        #     sender=self.config['email']['address'],
        #     recipient=[register_info.email],
        #     subject='THUD verification token',
        #     content=token,
        #     hostname=self.config['email']['hostname'],
        #     port=self.config['email']['port'],
        #     username=self.config['email']['username'],
        #     password=self.config['email']['password']
        # )

        # print('email:', resp)

        return schemas.user.User(
            id=user.id,
            username=user.username,
            date_joined=user.date_joined,
        )
            
    async def delete_user(self, id: ID) -> None:
        stmt = delete(models.user.User).where(models.user.User.id == id)
        async with self.db.get_session() as session:
            await session.execute(stmt)
            await session.commit()


    async def username_to_id(username: str) -> int | None:
        """
        Returns the ID of `username`, None if account with `username` does not exist
        """

    # async def search_users(self, user_id: int) -> list[schemas.user.User]:
    #     users = []
    #     stmt = select(models.user.User)
    #     async with self.db.get_session() as session:
    #         users = await session.scalars(stmt)

    async def get_user(self, id: ID=None, username: str=None) -> schemas.user.User | None:
        if id is not None:
            stmt = select(models.user.User).where(models.user.User.id == id)
        elif username is not None:
            stmt = select(models.user.User).where(models.user.User.username == username)
        else:
            return None
        async with self.db.get_session() as session:
            user: models.user.User = await session.scalar(stmt)

        if user is None:
            return None

        post_stmt = select(models.content.Post.id).where(models.content.Post.creator == user.id)
        comment_stmt = select(models.content.Comment.post).where(models.content.Comment.creator == user.id)
        like_stmt = select(models.content.Like.post).where(models.content.Like.user == user.id)
        save_stmt = select(models.content.Save.post).where(models.content.Save.user == user.id)
        followers_stmt = select(models.user.Follows.follower).where(models.user.Follows.followee == user.id)
        followees_stmt = select(models.user.Follows.followee).where(models.user.Follows.follower == user.id)
        blocking_stmt = select(models.user.Blocks.blockee).where(models.user.Blocks.blocker == user.id)

        async with self.db.get_session() as session:
            posts = (await session.scalars(post_stmt)).all()
            comments = (await session.scalars(comment_stmt)).all()
            likes = (await session.scalars(like_stmt)).all()
            saves = (await session.scalars(save_stmt)).all()
            followers = (await session.scalars(followers_stmt)).all()
            followees = (await session.scalars(followees_stmt)).all()
            blocking = (await session.scalars(blocking_stmt)).all()

        user = schemas.user.User(
            id=user.id,
            username=user.username,
            date_joined=user.date_joined,
            email=user.email,
            bio=user.bio,
            profile_picture=user.profile_picture,
            posts=posts,
            comments=comments,
            liked=likes,
            saved=saves,
            followers=followers,
            followees=followees,
            blocking=blocking,
        )

        return user
    
    
    async def follow(self, follower: ID, followee: ID) -> bool:
        if follower == followee:
            return False
        user_follows = models.user.Follows(follower=follower, followee=followee)
        async with self.db.get_session() as session:
            session.add(user_follows)
            try:
                await session.commit()
            except Exception as e:
                print('follow exception:', e)
                return False

        await self.notification_service.create_notification(
            sender=follower,
            receiver=followee,
            type='follow',
            content=follower,
        )

        return True

    async def unfollow(self, follower: ID, followee: ID) -> bool:
        if follower == followee:
            return False
        stmt = delete(models.user.Follows).where(
            and_(
                models.user.Follows.follower == follower,
                models.user.Follows.followee == followee,
            )
        )
        async with self.db.get_session() as session:
            await session.execute(stmt)
            await session.commit()
        return True
    
    async def followers(self, followee: ID) -> list[ID]:
        stmt = select(models.user.Follows.follower).where(models.user.Follows.followee == followee)
        async with self.db.get_session() as session:
            res = (await session.scalars(stmt)).all()
        return res
        
    async def followees(self, follower: ID) -> list[ID]:
        stmt = select(models.user.Follows.followee).where(models.user.Follows.follower == follower)
        async with self.db.get_session() as session:
            res = (await session.execute(stmt)).all()
        return res

    async def block(self, blocker: ID, blockee: ID) -> bool:
        if blocker == blockee:
            return False
        blocks = models.user.Blocks(blocker=blocker, blockee=blockee)
        async with self.db.get_session() as session:
            session.add(blocks)
            try:
                await session.commit()
                return True
            except Exception as e:
                return False

    async def unblock(self, blocker: ID, blockee: ID) -> bool:
        if blocker == blockee:
            return False
        stmt = delete(models.user.Blocks).where(
            and_(
                models.user.Blocks.blocker == blocker,
                models.user.Blocks.blockee == blockee,
            )
        )
        async with self.db.get_session() as session:
            await session.execute(stmt)
            await session.commit()
        return True