from .base import *
from datetime import datetime


class SendMessageRequest(BaseModel):
    receiver        : ID
    message         : str


class Message(SendMessageRequest):
    sender          : ID
    timestamp       : datetime

class Chat(BaseModel):
    messages        : list[Message]

# class ChatResponse(BaseModel):
#     receiver        : ID
#     messages        : list[Message]