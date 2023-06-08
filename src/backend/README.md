# THUD backend

## Tech stack

- Database: SQLAlchemy
- Business logic: Python 3
- API & input validation: FastAPI
- Frontend code generation: OpenAPI


## Configuration

Needs a `config.yaml` file containing the following:

```
data_dir: [directory where uploaded media is saved]
auth:
  access_token_expire_minutes: 3600
  key: [generate key with `openssl rand -hex 32`]
  algorithm: HS256
db_url: sqlite+aiosqlite:/// [location where DB file is saved]
```