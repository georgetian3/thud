from pathlib import Path
from fastapi import UploadFile
from fastapi.responses import StreamingResponse
import aiofiles

async def download_file(path: Path, filename: str=None, media_type: str='octet-stream', chunk_size: int=1024 * 1024):
    if filename is None:
        filename = path.name
    async def iterfile():
        async with aiofiles.open(path, 'rb') as f:
            while chunk := await f.read(chunk_size):
                yield chunk
    headers = {'Content-Disposition': f'attachment; filename="{filename}"'}
    return StreamingResponse(iterfile(), headers=headers, media_type=media_type)

async def upload_file(in_file: UploadFile, path, chunk_size: int=1024 * 1024):
    async with aiofiles.open(path, 'wb') as out_file:
        while content := await in_file.read(chunk_size):
            await out_file.write(content)