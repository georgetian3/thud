import services.notifications
from fastapi import Depends, APIRouter, status
from controllers.documentedresponse import JDR, create_documentation, success_response, failed_response
from schemas.base import ID
from controllers.auth import get_active_user
import schemas.notification

notification_service: services.notifications.NotificationService = None

router = APIRouter()

get_notifications_success = JDR(status.HTTP_200_OK, 'Get notifications success', schemas.notification.Notifications)
@router.get('/', **create_documentation([get_notifications_success, failed_response]))
async def get_notifications(active_user: ID = Depends(get_active_user)):
    notifications = await notification_service.get_notifications(active_user)
    return get_notifications_success.response(notifications)

delete_notification_success = JDR(status.HTTP_200_OK, 'Delete notifications success')
@router.delete('/', **create_documentation([delete_notification_success, failed_response]))
async def delete_notification(notification: schemas.notification.DeleteNotificationRequest, active_user: ID = Depends(get_active_user)):
    success = await notification_service.delete_notification(active_user, notification)
    return success_response.response()
