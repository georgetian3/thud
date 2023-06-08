from .base import *
from schemas.base import ID


class Message(DeclarativeBase):
    __tablename__   = 'message'
    id              : Mapped[ID]       = mapped_column(primary_key=True)
    sender          : Mapped[ID]       = mapped_column(ForeignKey('user.id'), nullable=False)
    receiver        : Mapped[ID]       = mapped_column(ForeignKey('user.id'), nullable=False)
    message         : Mapped[str]      = mapped_column(nullable=False)
    timestamp       : Mapped[datetime] = mapped_column(nullable=False)