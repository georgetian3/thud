from .base import *
from schemas.base import ID

# class Draft(DeclarativeBase):
#     __tablename__   = 'draft'
#     id              : Mapped[ID]       = mapped_column(primary_key=True)
#     author          : Mapped[ID]       = mapped_column(ForeignKey('user.id'), nullable=False)
#     content         : Mapped[str]      = mapped_column(nullable=False)
#     date_edited     : Mapped[datetime] = mapped_column(nullable=False)

class Post(DeclarativeBase):
    __tablename__   = 'post'
    id              : Mapped[ID]       = mapped_column(primary_key=True)
    creator         : Mapped[ID]       = mapped_column(ForeignKey('user.id'), nullable=False)
    title           : Mapped[str]      = mapped_column(nullable=False)
    content         : Mapped[str]      = mapped_column(nullable=False)
    date_created    : Mapped[datetime] = mapped_column(nullable=False)
    location        : Mapped[str]      = mapped_column(nullable=True)
    
class Comment(DeclarativeBase):
    __tablename__   = 'comment'
    id              : Mapped[ID]       = mapped_column(primary_key=True)
    creator         : Mapped[ID]       = mapped_column(ForeignKey('user.id'), nullable=False)
    post            : Mapped[ID]       = mapped_column(ForeignKey('post.id'), nullable=False)
    date_created    : Mapped[datetime] = mapped_column(nullable=False)
    content         : Mapped[str]      = mapped_column(nullable=False)

class Media(DeclarativeBase):
    __tablename__   = 'media'
    media           : Mapped[ID]       = mapped_column(primary_key=True)
    post            : Mapped[ID]       = mapped_column(ForeignKey('post.id'), nullable=True)

class Tag(DeclarativeBase):
    __tablename__   = 'tag'
    post            : Mapped[ID]       = mapped_column(ForeignKey('post.id'), primary_key=True)
    tag             : Mapped[str]      = mapped_column(primary_key=True)

class Like(DeclarativeBase):
    __tablename__   = 'like'
    post            : Mapped[ID]       = mapped_column(ForeignKey('post.id'), primary_key=True)
    user            : Mapped[ID]       = mapped_column(ForeignKey('user.id'), primary_key=True)
    timestamp       : Mapped[datetime] = mapped_column(nullable=False)

class Save(DeclarativeBase):
    __tablename__   = 'save'
    post            : Mapped[ID]       = mapped_column(ForeignKey('post.id'), primary_key=True)
    user            : Mapped[ID]       = mapped_column(ForeignKey('user.id'), primary_key=True)
    timestamp       : Mapped[datetime] = mapped_column(nullable=False)

class Notification(DeclarativeBase):
    __tablename__   = 'notification'
    id              : Mapped[ID]       = mapped_column(primary_key=True)
    sender          : Mapped[ID]       = mapped_column(ForeignKey('user.id'), nullable=False)
    receiver        : Mapped[ID]       = mapped_column(ForeignKey('user.id'), nullable=False)
    type            : Mapped[str]      = mapped_column(nullable=False)
    content         : Mapped[ID]       = mapped_column(nullable=True)
    timestamp       : Mapped[datetime] = mapped_column(nullable=False)