import models.content
import models.db
from models.base import *
import models.notification
from datetime import datetime
from models.base import ID

class NotificationService:

    def __init__(self, config, db: models.db.Database):
        self.config = config
        self.db = db

    async def create_notification(self, sender: ID, receiver: ID, type: str, content: ID=None):
        if sender == receiver:
            return
        async with self.db.get_session() as session:
            session.add(models.content.Notification(
                sender=sender,
                receiver=receiver,
                type=type,
                content=content,
                timestamp=datetime.utcnow(),
            ))
            try:
                await session.commit()
            except Exception as e:
                print('create notification failed:', e)

    async def delete_notification(self, user, notification):
        stmt = delete(models.content.Notification).where(
            and_(
                models.content.Notification.id == notification.id,
                models.content.Notification.receiver == user
            )
        ) 
        async with self.db.get_session() as session:
            await session.execute(stmt)
            await session.commit()

    async def get_notifications(self, user: ID) -> models.notification.Notifications:
        stmt = select(models.content.Notification).where(
            models.content.Notification.receiver == user
        )
        async with self.db.get_session() as session:
            notifications = (await session.scalars(stmt)).all()

        return models.notification.Notifications(
            notifications=[
                models.notification.Notification(
                    id=notification.id,
                    sender=notification.sender,
                    type=notification.type,
                    content=notification.content,
                    timestamp=notification.timestamp,
                ) for notification in notifications
            ],
        )