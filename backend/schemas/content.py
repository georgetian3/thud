from .base import *
from enum import Enum
from datetime import datetime

class CreatePostRequest(BaseModel):
    tags            : list[str] = []
    title           : str
    content         : str
    location        : str | None
    media_count     : int = 0

    @validator('content')
    def content_format(cls, content):
        try:
            json.loads(content)
        except json.JSONDecodeError:
            raise ValueError('Invalid content JSON format')
        return content
    
    @validator('media_count')
    def media_count_format(cls, media_count):
        if media_count < 0:
            raise ValueError('Media count must be non-negative')
        return media_count

class CreatePostSuccessResponse(BaseModel):
    post            : ID
    media           : list[ID] = []

class UploadMediaRequest(BaseModel):
    post_id         : ID

class CreateCommentRequest(BaseModel):
    content         : str

class Comment(BaseModel):
    id              : ID
    creator         : ID
    content         : str
    date_created    : datetime

class Post(BaseModel):
    id              : ID
    creator         : ID
    title           : str
    content         : str
    location        : str | None
    date_created    : datetime
    tags            : list[str]
    media           : list[ID]
    comments        : list[Comment]
    likers          : list[ID]
    savers          : list[ID]






sort_methods = {
    'hot',          # calculate_hotness
    'best',         # 点赞数最多
    'new',          # 创建时间最新
    'comments',     # 评论数量最多
}

class SearchContentRequest(BaseModel):
    # 多关键词联合搜索
    keywords         : str = ''
    # 仅显示关注用户创建的内容
    followed_only    : bool = False
    # 以下四个变量指的是在什么特征中进行搜索，
    # 比如如果 search_in_title, search_in_tags = True,
    # search_in_content, search_in_username = False
    # 则仅在标题和标签中进行搜索
    search_title     : bool = True       
    search_tags      : bool = True
    search_content   : bool = True
    search_username  : bool = True
    search_comments  : bool = True
    sort_method      : str = 'new' # see sort_methods

class LikeRequest(BaseModel):
    post_id         : ID