import json

from fastapi import FastAPI
from fastapi.routing import APIRouter
from fastapi.openapi.utils import get_openapi
from fastapi.middleware.cors import CORSMiddleware


import services.content
import services.user
import services.chat
import services.notifications

import models.db

from . import (
    content,
    user,
    auth,
    chat,
    notification,
)

import yaml


class App:
    def __init__(self, config='config.yaml'):

        with open(config, encoding='utf8') as f:
            config = yaml.safe_load(f)

        self.db = models.db.Database(config['db_url'])


        self.api = FastAPI(
            title='thudAPI',
            description='API for thud',
        )

        self.api.add_middleware(
            CORSMiddleware,
            allow_origins=['*'],
            allow_credentials=True,
            allow_methods=['*'],
            allow_headers=['*'],
        )

        self.notification_service = services.notifications.NotificationService(config, self.db)
        self.user_service = services.user.UserService(config, self.db, self.notification_service)
        self.content_service = services.content.ContentService(config, self.db, self.notification_service, self.user_service)
        self.chat_service = services.chat.ChatService(config, self.db, self.notification_service)

        notification.notification_service = self.notification_service
        chat.chat_service = self.chat_service
        content.content_service = self.content_service
        content.config = config
        user.user_service = self.user_service
        auth.user_service = self.user_service
        auth.config = config

        api_router = APIRouter(prefix='')
        api_router.include_router(auth.router, prefix='', tags=['auth'])
        api_router.include_router(user.router, prefix='/users', tags=['users'])
        api_router.include_router(content.router, prefix='', tags=['content'])
        api_router.include_router(chat.router, prefix='/chat', tags=['chat'])
        api_router.include_router(notification.router, prefix='/notifications', tags=['notification'])

        self.api.include_router(api_router)

    def reset_db(self):
        self.db.reset()

    def generate_docs(self):
        with open('openapi.json', 'w') as f:
            json.dump(get_openapi(
                title=self.api.title,
                version=self.api.version,
                openapi_version=self.api.openapi_version,
                description=self.api.description,
                routes=self.api.routes,
            ), f)