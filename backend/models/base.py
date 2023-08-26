from datetime import datetime
from sqlalchemy import ForeignKey, select, delete, update, or_, and_
from sqlalchemy.exc import IntegrityError
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy.orm import declarative_base, Mapped, mapped_column
DeclarativeBase = declarative_base()