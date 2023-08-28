from .base import *
from models.base import ID
from typing import Optional
import re
from pydantic import validator

class UserBase(SQLModel):
    id              : ID = Field(primary_key=True)
    username        : str
    profile_picture : ID
    password_hash   : str
    date_joined     : datetime
    bio             : str

class UserDB(UserBase, table=True):
    ...

class User(UserBase):
    posts           : list[ID] = []   # list of post IDs submitted by user
    comments        : list[ID] = []   # list of comment IDs submitted by user
    liked           : list[ID] = []   # list of post/comment IDs liked by user
    saved           : list[ID] = []   # list of post/comment IDs saved by user
    followers       : list[ID] = []   # list of users' usernames followed by user
    followees       : list[ID] = []   # list of users' usernames following the user
    blocking        : list[ID] = []

class Follows(SQLModel, table=True):
    __tablename__       = 'user_follows'
    follower        : int = Field(primary_key=True)
    followee        : int = Field(primary_key=True)

class Blocks(SQLModel, table=True):
    __tablename__       = 'user_blocks'
    blocker         : int = Field(primary_key=True)
    blockee         : int = Field(primary_key=True)



class Username(BaseModel):
    username: str
    __chars = r'A-Za-z0-9_\.\_'
    __min_length = 1
    __max_length = 32
    __pattern = re.compile(fr'[{__chars}]{{{__min_length},{__max_length}}}')


    @validator('username')
    def username_format(cls, username):
        if not re.fullmatch(Username.__pattern, username):
            raise ValueError('Username format incorrect')
        return username

    
    class Config:
        schema_extra = {
            'example': {
                'username': 'johndoe',
            }
        }

class Password(BaseModel):
    password: str
    __min_length = 8
    __max_length = 64
    __chars = r'\x20-\x7e' # printable chars excluding delete
    __pattern = re.compile(fr'[{__chars}]{{{__min_length},{__max_length}}}')
    @validator('password')
    def password_format(cls, password):
        if not re.fullmatch(Password.__pattern, password):
            raise ValueError('Password format incorrect')
        return password

class RegisterRequest(Username, Password):
    class Config:
        schema_extra = {
            'example': {
                'username': 'johndoe',
                'password': 'secret123',
            }
        }

class FollowRequest(BaseModel):
    followee        : ID

class ChangePasswordRequest(BaseModel):
    old_password    : str
    new_password    : Password

class ChangeUsernameRequest(BaseModel):
    new_username    : Username

class ProfilePictureId(BaseModel):
    id              : ID

class ChangeBioRequest(BaseModel):
    bio             : str