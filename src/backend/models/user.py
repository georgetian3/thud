from .base import *
from schemas.base import ID

class User(DeclarativeBase):
    __tablename__       = 'user'
    id                  : Mapped[ID]        = mapped_column(primary_key=True)
    username            : Mapped[str]       = mapped_column(unique=True, nullable=False)
    #verification        : Mapped[int]       = mapped_column(nullable=False)
    profile_picture     : Mapped[ID]        = mapped_column(nullable=True)
    password_hash       : Mapped[str]       = mapped_column(nullable=False)
    date_joined         : Mapped[datetime]  = mapped_column(nullable=False)
    email               : Mapped[str]       = mapped_column(unique=True, nullable=True)
    bio                 : Mapped[str]       = mapped_column(nullable=False)

    def __repr__(self):
        return '\nUser\n    ' + '\n    '.join(f'{k}: {self.__dict__[k]}' for k in self.__dict__ if k[0] != '_') + '\n'

# class VerificationToken(DeclarativeBase):
#     __tablename__       = 'verification_token'
#     user_id             : Mapped[str]       = mapped_column(ForeignKey('user.id'), primary_key=True)
#     token               : Mapped[str]       = mapped_column(nullable=False)
#     expires             : Mapped[datetime]  = mapped_column(nullable=False)

class Follows(DeclarativeBase):
    __tablename__       = 'user_follows'
    follower            : Mapped[int]       = mapped_column(ForeignKey('user.id'), primary_key=True)
    followee            : Mapped[int]       = mapped_column(ForeignKey('user.id'), primary_key=True)

class Blocks(DeclarativeBase):
    __tablename__       = 'user_blocks'
    blocker             : Mapped[int]       = mapped_column(ForeignKey('user.id'), primary_key=True)
    blockee             : Mapped[int]       = mapped_column(ForeignKey('user.id'), primary_key=True)

# class TagFollows(DeclarativeBase):
#     __tablename__       = 'tag_follows'
#     user_id             : Mapped[int]       = mapped_column(ForeignKey('user.id'), primary_key=True)
#     tag                 : Mapped[int]       = mapped_column(ForeignKey('tag.tag'), primary_key=True)

# class TagBlocks(DeclarativeBase):
#     __tablename__       = 'tag_blocks'
#     user_id             : Mapped[int]       = mapped_column(ForeignKey('user.id'), primary_key=True)
#     tag                 : Mapped[int]       = mapped_column(ForeignKey('tag.tag'), primary_key=True)


# class Settings(DeclarativeBase):
#     __tablename__       = 'settings'
#     user                : Mapped[int]       = mapped_column(ForeignKey('user.id'), primary_key=True)
#     visibility          : Mapped[str]       = mapped_column(nullable=False)