import services.chat
from fastapi import Depends, APIRouter, UploadFile, status
from controllers.documentedresponse import JDR, create_documentation, success_response, failed_response
from models.base import ID
from controllers.auth import get_active_user
import pathlib
import models.chat

chat_service: services.chat.ChatService = None

router = APIRouter()


@router.put('/', **create_documentation([success_response, failed_response]))
async def send_message(
    message: models.chat.SendMessageRequest,
    active_user: ID = Depends(get_active_user),
):
    await chat_service.send_message(active_user, message)



get_messages_success = JDR(status.HTTP_200_OK, 'Get messages success', models.chat.Chat)
@router.get('/', **create_documentation([get_messages_success, failed_response]))
async def get_messages(
    active_user: ID = Depends(get_active_user),
):
    messages = await chat_service.get_messages(active_user)
    return get_messages_success.response(messages)
