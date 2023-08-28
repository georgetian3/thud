import models.chat
import models.db
from models.base import *
import models.chat
from datetime import datetime
from services.notifications import NotificationService

class ChatService:

    def __init__(self, config, db: models.db.Database, notification_service: NotificationService):
        self.config = config
        self.db = db
        self.notification_service = notification_service

    async def send_message(self, user: ID, new_message: models.chat.SendMessageRequest):
        message = models.chat.Message(
            sender=user,
            receiver=new_message.receiver,
            message=new_message.message,
            timestamp=datetime.utcnow(),
        )
        async with self.db.get_session() as session:
            session.add(message)
            await session.commit()

        await self.notification_service.create_notification(
            sender=user,
            receiver=new_message.receiver,
            type='message',
        )
        

    async def get_messages(self, user: ID) -> models.chat.Chat:
        stmt = select(models.chat.Message).where(
            or_(
                models.chat.Message.sender == user,
                models.chat.Message.receiver == user
            )
        )
        async with self.db.get_session() as session:
            messages = (await session.scalars(stmt)).all()

        return models.chat.Chat(
            messages=[
                models.chat.Message(
                    sender=message.sender,
                    receiver=message.receiver,
                    message=message.message,
                    timestamp=message.timestamp,
                )
                for message in messages
            ]
        )