from typing import Optional
from email_validator import validate_email
from .base import *

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

class Email(BaseModel):
    email: str
    __pattern = re.compile(r'.*?@mails?\.tsinghua\.edu\.cn')
    @validator('email')
    def email_format(cls, email):
        try:
            if not validate_email(email=email, check_deliverability=False):
                raise ValueError('Invalid email')
        except:
            raise ValueError('Invalid email')

        return email

    class Config:
        schema_extra = {
            'example': {
                'email': 'johndoe@example.com',
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

class VerifyRequest(Email):
    pass

class RegisterRequest(Username, Password):
    class Config:
        schema_extra = {
            'example': {
                'username': 'johndoe',
                'password': 'secret123',
            }
        }

class EditProfileRequest(BaseModel):
    username: Optional[str]
    password: Optional[str]
    bio     : Optional[str]

class User(BaseModel):
    id              : ID
    username        : str               # username of user
    profile_picture : ID | None = None  # media ID of profile picture
    date_joined     : datetime          # datetime when user's account was created
    email           : str | None = None # user's email
    bio             : str | None = None # user's biography
    posts           : list[ID] = []   # set of post IDs submitted by user
    comments        : list[ID] = []   # set of comment IDs submitted by user
    liked           : list[ID] = []   # set of post/comment IDs upvoted by user
    saved           : list[ID] = []   # set of post/comment IDs downvoted by user
    followers       : list[ID] = []   # set of users' usernames followed by user
    followees       : list[ID] = []   # set of users' usernames following the user
    blocking        : list[ID] = []


class FollowRequest(BaseModel):
    followee        : ID

class ChangePasswordRequest(BaseModel):
    old_password    : str
    new_password    : str


class ChangeUsernameRequest(BaseModel):
    new_username    : str

class ProfilePictureId(BaseModel):
    id              : ID

class ChangeBioRequest(BaseModel):
    bio             : str