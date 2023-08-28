from datetime import datetime
from sqlalchemy import ForeignKey, select, delete, update, or_, and_
from sqlalchemy.exc import IntegrityError
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession

from sqlmodel import SQLModel, Field
from pydantic import BaseModel


from datetime import datetime
import re
from typing import Optional
from pydantic import BaseModel, validator
import json

ID = int

class JsonInFormBase(BaseModel):
    @classmethod
    def __get_validators__(cls):
        yield cls.validate_to_json

    @classmethod
    def validate_to_json(cls, value):
        if isinstance(value, str):
            return cls(**json.loads(value))
        return value