"""
Auth controller
"""

from datetime import datetime, timedelta

from fastapi import Depends, HTTPException, status
from fastapi.routing import APIRouter
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from jose import jwt

import models.auth
import models.user
import services.user
from controllers.documentedresponse import JDR, create_documentation
from models.base import ID

router = APIRouter()

# https://fastapi.tiangolo.com/tutorial/security/oauth2-jwt/

config = {}
user_service: services.user.UserService = None
oauth2_scheme = OAuth2PasswordBearer(tokenUrl='login')

def create_access_token(user_id: ID) -> models.auth.Token:
    return models.auth.Token(
        access_token=jwt.encode(
            {
                'sub': str(user_id),
                'exp': datetime.utcnow() + timedelta(minutes=config['auth']['access_token_expire_minutes']),
            },
            config['auth']['key'],
            algorithm=config['auth']['algorithm']
        ),
        token_type='bearer',
    )


# blacklist = {}

def get_active_user(token: str = Depends(oauth2_scheme)) -> ID:
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail='Could not validate credentials',
        headers={'WWW-Authenticate': 'Bearer'},
    )

    try:
        payload = jwt.decode(token, config['auth']['key'], algorithms=config['auth']['algorithm'])
        user_id: ID = ID(payload.get('sub'))
        if user_id is None:
            raise credentials_exception
    except:
        raise credentials_exception

    return user_id


################################################################################

login_success_jdr = JDR(status.HTTP_200_OK, 'Login successful', models.auth.Token)
incorrect_credentials_jdr = JDR(status.HTTP_401_UNAUTHORIZED, 'Username or password incorrect')
unverified_jdr = JDR(status.HTTP_403_FORBIDDEN, 'Verify email first')

@router.post('/login', **create_documentation([login_success_jdr, incorrect_credentials_jdr]))

async def login(login_request: OAuth2PasswordRequestForm = Depends()):
    user_id = await user_service.authenticate(
        login_request.username,
        login_request.password
    )
    if user_id is None:
        return incorrect_credentials_jdr.response()
    # if error == 2:
    #     return unverified_jdr.response()

    return create_access_token(user_id)


################################################################################

logout_sucess_jdr = JDR(status.HTTP_204_NO_CONTENT, 'Logout successful')
@router.post('/logout', **create_documentation([logout_sucess_jdr]))
async def logout(active_user: ID = Depends(get_active_user)):
    """Logout"""
    _ = active_user

################################################################################

register_successful_jdr = JDR(status.HTTP_201_CREATED, 'Registration successful')
register_failed_jdr = JDR(status.HTTP_400_BAD_REQUEST, 'Registration failed')
@router.put('/register', **create_documentation([register_successful_jdr, register_failed_jdr]))
async def register(register_request: models.user.RegisterRequest):
    """Register"""
    user_response = await user_service.create_user(register_request)
    if user_response is None:
        return register_failed_jdr.response()
    return register_successful_jdr.response()

