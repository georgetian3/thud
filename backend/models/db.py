import asyncio
from contextlib import asynccontextmanager

import SQLModel
from sqlalchemy import text
from sqlalchemy.ext.asyncio import AsyncSession, async_session

from .chat import *
from .content import *
from .notification import *
from .user import *


class Database:

    def __init__(self, url='sqlite+aiosqlite:///thud.db'):
        self.__engine = create_async_engine(url, echo=False)
        self.__async_sessionmaker = async_session(self.__engine)
        self.__is_sqlite = self.__engine.name == 'sqlite'

    @asynccontextmanager
    async def get_session(self) -> AsyncSession:
        async with self.__async_sessionmaker() as session:
            if self.__is_sqlite:
                await session.execute(text('pragma foreign_keys=on'))
            yield session

    def reset(self):
        async def __init_db():
            async with self.__engine.begin() as conn:
                await conn.run_sync(SQLModel.metadata.drop_all)
                await conn.run_sync(SQLModel.metadata.create_all)
        asyncio.run(__init_db())