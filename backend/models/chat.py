from .base import *

class SendMessageRequest(SQLModel):
    receiver        : ID
    message         : str


class Message(SendMessageRequest):
    sender          : ID
    timestamp       : datetime

class Chat(BaseModel):
    messages        : list[Message]

class MessageDB(Message, table=True):
    __tablename__   = 'message'
    id: int = Field(primary_key=True)