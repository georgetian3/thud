from schemas.base import *
from enum import Enum


NotificationType = Enum('NotificationType',
    [
        'comment',
        'like',
        'follow',
        'save',
        'post',
        'message',
    ]
)



class Notification(BaseModel):
    id          : ID
    sender      : ID
    type        : str
    content     : ID | None
    timestamp   : datetime

class Notifications(BaseModel):
    notifications: list[Notification]

class DeleteNotificationRequest(BaseModel):
    id:         ID