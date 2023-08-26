from fastapi import status, Depends, UploadFile
from fastapi.routing import APIRouter
import services.user
import schemas.user
import schemas.auth
from schemas.base import ID
from .documentedresponse import create_documentation, JDR, success_response, failed_response
from controllers.auth import get_active_user, create_access_token
from utils.filetransfer import upload_file

config = {}
router = APIRouter()
user_service: services.user.UserService = None

get_me_successful = JDR(status.HTTP_200_OK, 'Get me successful', schemas.user.User)
@router.get('/me', **create_documentation([get_me_successful]))
async def get_me(active_user: ID = Depends(get_active_user)):
    me = await user_service.get_user(id=active_user)
    return me
    


get_user_successful = JDR(status.HTTP_200_OK, 'Get user successful', schemas.user.User)
user_not_found = JDR(status.HTTP_404_NOT_FOUND, 'User not found')
@router.get('/id/{user_id}', **create_documentation([get_user_successful, user_not_found]))
async def get_user_id(user_id: ID, active_user: ID = Depends(get_active_user)):
    user = await user_service.get_user(id=user_id)
    if user is None:
        return user_not_found.response()
    return get_user_successful.response(user)


@router.get('/username/{username}', **create_documentation([get_user_successful, user_not_found]))
async def get_user_username(username: str, active_user: ID = Depends(get_active_user)):
    user = await user_service.get_user(username=username)
    if user is None:
        return user_not_found.response()
    return get_user_successful.response(user)


@router.post('/id/{user_id}/follow', **create_documentation([success_response, failed_response]))
async def follow(user_id: ID, active_user: ID = Depends(get_active_user)):
    return success_response.response() if await user_service.follow(active_user, user_id) else failed_response.response()

@router.post('/id/{user_id}/unfollow', **create_documentation([success_response, failed_response]))
async def unfollow(user_id: ID, active_user: ID = Depends(get_active_user)):
    return success_response.response() if await user_service.unfollow(active_user, user_id) else failed_response.response()

@router.post('/id/{user_id}/block', **create_documentation([success_response, failed_response]))
async def block(user_id: ID, active_user: ID = Depends(get_active_user)):
    return success_response.response() if await user_service.block(active_user, user_id) else failed_response.response()

@router.post('/id/{user_id}/unblock', **create_documentation([success_response, failed_response]))
async def unblock(user_id: ID, active_user: ID = Depends(get_active_user)):
    return success_response.response() if await user_service.unblock(active_user, user_id) else failed_response.response()


@router.patch('/me/username', **create_documentation([success_response, failed_response]))
async def change_username(username: schemas.user.ChangeUsernameRequest, active_user: ID = Depends(get_active_user)):
    success = await user_service.change_username(active_user, username.new_username)
    if not success:
        return failed_response.response()
    return success_response.response()


change_password_success = JDR(status.HTTP_200_OK, 'Change password success', schemas.auth.Token)
@router.patch('/me/password', **create_documentation([change_password_success, failed_response]))
async def change_password(passwords: schemas.user.ChangePasswordRequest, active_user: ID = Depends(get_active_user)):
    success = await user_service.change_password(active_user, passwords.old_password, passwords.new_password)
    if not success:
        return failed_response.response()
    return change_password_success.response(create_access_token(active_user))


change_profile_picture_success = JDR(status.HTTP_200_OK, 'Change profile picture success', schemas.user.ProfilePictureId)
@router.patch('/me/profile-picture', **create_documentation([change_profile_picture_success, failed_response]))
async def change_profile_picture(profile_picture: UploadFile, active_user: ID = Depends(get_active_user)):
    media_id, path = await user_service.change_profile_picture(active_user)
    await upload_file(profile_picture, path)
    return change_profile_picture_success.response(schemas.user.ProfilePictureId(id=media_id))

@router.patch('/me/bio', **create_documentation([success_response, failed_response]))
async def change_bio(bio: schemas.user.ChangeBioRequest, active_user: ID = Depends(get_active_user)):
    await user_service.change_bio(active_user, bio.bio)
    return success_response.response()