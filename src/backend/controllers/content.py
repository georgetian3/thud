from fastapi import Depends, APIRouter, UploadFile, status
from controllers.documentedresponse import JDR, create_documentation, success_response, failed_response, not_found_jdr
import schemas.content
import services.content
from schemas.base import ID
from utils.filetransfer import upload_file, download_file
from controllers.auth import get_active_user
from mimetypes import MimeTypes

import platform
if 'win' in platform.platform().lower():
    from winmagic import magic
else:
    import magic

config = {}
router = APIRouter()
content_service: services.content.ContentService = None



get_post_success = JDR(status.HTTP_200_OK, 'Got post successfully', schemas.content.Post)

@router.get('/posts/{post_id}', **create_documentation([get_post_success, not_found_jdr]))
async def get_post(post_id: ID):
    post = await content_service.get_post(post_id)
    if post is None:
        return not_found_jdr.response()
    return get_post_success.response(post)


create_post_success = JDR(status.HTTP_201_CREATED, 'Post created successfully', schemas.content.CreatePostSuccessResponse)
create_post_failed = JDR(status.HTTP_400_BAD_REQUEST, 'Post creation failed')
@router.put('/posts', **create_documentation([create_post_success, create_post_failed]))
async def create_post(
    new_post: schemas.content.CreatePostRequest,
    active_user: ID = Depends(get_active_user),
):
    res = await content_service.create_post(active_user, new_post)
    post_id, media_ids = res
    if not isinstance(res, tuple):
        return create_post_failed.response()
    return create_post_success.response(
        schemas.content.CreatePostSuccessResponse(
            post=post_id,
            media=media_ids
        )
    )


search_post_success = JDR(status.HTTP_200_OK, 'Search successful', list[schemas.content.Post])
@router.post('/posts/', **create_documentation([search_post_success]))
async def search_posts(
    query: schemas.content.SearchContentRequest,
    active_user: ID = Depends(get_active_user)
):
    return await content_service.search_posts(active_user, query)
    

create_comment_success = JDR(status.HTTP_201_CREATED, 'Create comment successful', schemas.content.Comment)
@router.put('/posts/{post_id}/comments', **create_documentation([create_comment_success, failed_response]))
async def create_comment(post_id: ID, comment: schemas.content.CreateCommentRequest, active_user: ID = Depends(get_active_user)):
    comment = await content_service.create_comment(active_user, post_id, comment)
    if comment is None:
        return failed_response.response()
    return create_comment_success.response(comment)

################################################################################


@router.patch('/posts/{post_id}/like', **create_documentation([success_response, failed_response]))
async def like(post_id: ID, active_user: ID = Depends(get_active_user)):
    success = await content_service.like(active_user, post_id)
    return success_response.response() if success else failed_response.response()

@router.patch('/posts/{post_id}/unlike', **create_documentation([success_response, failed_response]))
async def unlike(post_id: ID, active_user: ID = Depends(get_active_user)):
    success = await content_service.unlike(active_user, post_id)
    return success_response.response() if success else failed_response.response()


@router.patch('/posts/{post_id}/save', **create_documentation([success_response, failed_response]))
async def save(post_id: ID, active_user: ID = Depends(get_active_user)):
    success = await content_service.save(active_user, post_id)
    return success_response.response() if success else failed_response.response()


@router.patch('/posts/{post_id}/unsave', **create_documentation([success_response, failed_response]))
async def unsave(post_id: ID, active_user: ID = Depends(get_active_user)):
    success = await content_service.unsave(active_user, post_id)
    return success_response.response() if success else failed_response.response()


################################################################################



upload_media_success = JDR(status.HTTP_200_OK, 'Media uploaded successfully')
upload_media_failed = JDR(status.HTTP_400_BAD_REQUEST, 'Media upload failed')
@router.put('/media/{media_id}', **create_documentation([upload_media_success, upload_media_failed]))
async def put_media(
    media_id: ID, file: UploadFile,
    active_user: ID = Depends(get_active_user),
):
    path = await content_service.upload_media(active_user, media_id)
    if path is None:
        return upload_media_failed.response()
    await upload_file(file, path)

    return upload_media_success.response()


mime_types = MimeTypes()
@router.api_route('/media/{media_id}', methods=['GET', 'HEAD'])
async def get_media(media_id: int):
    path = content_service.media_id_to_path(media_id)
    media_type = magic.from_file(path, mime=True)
    filename = path.with_suffix(mime_types.guess_extension(media_type)).name
    try:
        return await download_file(path, filename=filename, media_type=media_type)
    except FileNotFoundError:
        return 404