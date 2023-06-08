from .base import *
from schemas.user import Username, Password

class Token(BaseModel):
    access_token: str
    token_type: str

class RegisterFailedJDR(BaseModel):
    duplicates: set = set()

class LoginRequest(Username, Password):
    class Config:
        schema_extra = {
            'example': {
                'username': 'johndoe',
                'password': 'secret123',
            }
        }
