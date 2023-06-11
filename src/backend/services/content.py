import models.content

import models.user
import models.db
from models.base import *
import schemas.content
from datetime import datetime
from schemas.base import ID
import pathlib
from services.user import UserService
from services.notifications import NotificationService
import json

class ContentService:

    def __init__(self, config, db: models.db.Database,
        notification_service: NotificationService,
        user_service: UserService
    ):
        self.config = config
        self.db = db
        self.data_dir = pathlib.Path(config['data_dir'])
        self.data_dir.mkdir(parents=True, exist_ok=True)
        self.notification_service = notification_service
        self.user_service = user_service


    async def create_post(self,
        user_id: int,
        new_post: schemas.content.CreatePostRequest,
    ) -> str | None:

        post = models.content.Post(
            creator=user_id,
            title=new_post.title,
            content=new_post.content,
            date_created=datetime.utcnow(),
            location=new_post.location,
        )

        async with self.db.get_session() as session:
            session.add(post)
            try:
                await session.commit()
            except models.db.IntegrityError as e:
                return None
            
            await session.refresh(post)
            post_id = post.id

            for tag in new_post.tags:
                session.add(models.content.Tag(post=post_id, tag=tag))
            await session.commit()
                
            media = [models.content.Media(post=post_id) for _ in range(new_post.media_count)]

            for i in range(new_post.media_count):
                session.add(media[i])
            await session.commit()

            for i in range(new_post.media_count):
                await session.refresh(media[i])

        for user in await self.user_service.followers(user_id):
            await self.notification_service.create_notification(
                sender=user_id,
                receiver=user,
                type='post',
                content=post_id,
            )

        return post_id, {x.media for x in media}
    
    async def create_comment(self, user_id: ID, post_id: ID, comment: schemas.content.CreateCommentRequest) -> schemas.content.Comment | None:
        comment = models.content.Comment(
            creator=user_id,
            post=post_id,
            content=comment.content,
            date_created=datetime.utcnow(),
        )

        async with self.db.get_session() as session:
            session.add(comment)
            try:
                await session.commit()
                await session.refresh(comment)
            except:
                return None
            op = await session.scalar(
                select(models.content.Post.creator).where(models.content.Post.id == post_id)
            )
            
        await self.notification_service.create_notification(
            sender=user_id,
            receiver=op,
            type='comment',
            content=post_id,
        )
            
        return schemas.content.Comment(
            id=comment.id,
            creator=comment.creator,
            content=comment.content,
            date_created=comment.date_created,
        )



    async def get_post(self, post_id: ID) -> schemas.content.Post | None:
        post_stmt = select(models.content.Post).where(models.content.Post.id == post_id)
        comment_stmt = select(models.content.Comment).where(models.content.Comment.post == post_id)
        tag_stmt = select(models.content.Tag.tag).where(models.content.Tag.post == post_id)
        like_stmt = select(models.content.Like.user).where(models.content.Like.post == post_id)
        save_stmt = select(models.content.Save.user).where(models.content.Save.post == post_id)
        media_stmt = select(models.content.Media.media).where(models.content.Media.post == post_id)

        async with self.db.get_session() as session:
            post = await session.scalar(post_stmt)
            if post is None:
                return None
            comments = (await session.scalars(comment_stmt)).all()
            tags = (await session.scalars(tag_stmt)).all()
            likers = (await session.scalars(like_stmt)).all()
            savers = (await session.scalars(save_stmt)).all()
            media = (await session.scalars(media_stmt)).all()

        return schemas.content.Post(
            id=post_id,
            creator=post.creator,
            title=post.title,
            location=post.location,
            content=post.content,
            date_created=post.date_created,
            tags=tags,
            comments=[
                schemas.content.Comment(
                    id=comment.id,
                    creator=comment.creator,
                    content=comment.content,
                    date_created=comment.date_created,
                ) for comment in comments
            ],
            media=media,
            likers=set(likers),
            savers=savers
        )


    async def search_posts(self,
        user_id: ID,
        query: schemas.content.SearchContentRequest
    ) -> list[schemas.content.Post]:
        
        print('query')
        print(query)

        stmt = select(models.content.Post)

        async with self.db.get_session() as session:
            post_models = (await session.scalars(stmt)).all()
            posts = [await self.get_post(post.id) for post in post_models]
            user_followees = (await session.scalars(
                select(models.user.Follows.followee).where(
                    models.user.Follows.follower == user_id
                )
            )).all()
            user_blocking = (await session.scalars(
                select(models.user.Blocks.blockee).where(
                    models.user.Blocks.blocker == user_id
                )
            )).all()
        
        user_followees = {} if user_followees is None else set(user_followees)
        user_blocking = {} if user_blocking is None else set(user_blocking)

        filtered_posts = []

        keywords = [keyword.lower() for keyword in query.keywords.split()] if query.keywords else None



        def quill_delta_to_plaintext(delta: str) -> str:
            try:
                delta = json.loads(delta)
            except:
                return ''
            s = ''
            for d in delta:
                try:
                    s += d['insert']
                except:
                    continue
            return s
        print('posts')
        for post in posts:
            print(post)
            if post.creator in user_blocking:
                continue
            if query.followed_only and post.creator not in user_followees:
                continue
            if (not keywords or
                query.search_title and any(keyword in post.title.lower() for keyword in keywords) or
                query.search_tags and any(keyword in tag.lower() for keyword in keywords for tag in post.tags) or
                query.search_content and any(keyword in quill_delta_to_plaintext(post.content).lower() for keyword in keywords) or
                query.search_comments and any(keyword in comment.content.lower() for keyword in keywords for comment in post.comments) or
                query.search_username and any([
                    keyword in (await self.user_service.get_user(id=post.creator)).username.lower()
                    for keyword in keywords
                ])
            ):
                filtered_posts.append(post)

        def calculate_hotness(post: schemas.content.Post) -> float:
            return 7 / max(1, (datetime.utcnow() - post.date_created).days) + \
                len(post.likers) + 5 * len(post.savers) + 5 * len(post.comments)
        
        if query.sort_method == 'comments':
            key = lambda x: len(x.comments)
            reverse = True
        elif query.sort_method == 'best':
            key = lambda x: len(x.likers)
            reverse = True
        elif query.sort_method == 'hot':
            key = lambda x: calculate_hotness(x)
            reverse = True
        else: # default is sort by new
            key = lambda x: x.date_created
            reverse = True
            

        filtered_posts.sort(key=key, reverse=reverse)
        print('filtered')
        print(filtered_posts)
        
        return filtered_posts


    def media_id_to_path(self, media_id: ID) -> pathlib.Path:
        return self.data_dir / str(media_id)


    async def upload_media(self, user: ID, media: ID) -> pathlib.Path | None:

        # check if media_id belongs to user
        media_stmt = select(models.content.Media.post).where(models.content.Media.media == media)
        async with self.db.get_session() as session:
            post_id = await session.scalar(media_stmt)
            post = await session.scalar(
                select(models.content.Post).where(models.content.Post.id == post_id)
            )

        if post.creator != user:
            return
        
        # check if media has already been uploaded
        path = self.media_id_to_path(media)
        if path.is_file():
            return
        
        #await upload_file(file, path)
        return path
    

    async def like(self, user: ID, post: ID) -> bool:
        like = models.content.Like(
            user=user,
            post=post,
            timestamp=datetime.utcnow(),
        )
        async with self.db.get_session() as session:
            session.add(like)
            try:
                await session.commit()
            except:
                return False
        
        await self.notification_service.create_notification(
            sender=user,
            receiver=(await self.get_post(post)).creator,
            type='like',
            content=post,
        )

        return True
    
    async def unlike(self, user: ID, post: ID) -> bool:
        stmt = delete(models.content.Like).where(
            and_(
                models.content.Like.user == user,
                models.content.Like.post == post
            )
        )
        async with self.db.get_session() as session:
            await session.execute(stmt)
            try:
                await session.commit()
                return True
            except:
                return False

    async def save(self, user: ID, post: ID) -> bool:
        save = models.content.Save(
            user=user,
            post=post,
            timestamp=datetime.utcnow(),
        )
        async with self.db.get_session() as session:
            session.add(save)
            try:
                await session.commit()
            except:
                ...

        await self.notification_service.create_notification(
            sender=user,
            receiver=(await self.get_post(post)).creator,
            type='save',
            content=post,
        )

        return True

    async def unsave(self, user: ID, post: ID) -> bool:
        stmt = delete(models.content.Save).where(
            and_(
                models.content.Save.user == user,
                models.content.Save.post == post
            )
        )
        async with self.db.get_session() as session:
            await session.execute(stmt)
            try:
                await session.commit()
            except:
                ...
        return True