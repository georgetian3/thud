# pkill gunicorn
# git pull
# python3 main.py
py main.py
# gunicorn main:api -k uvicorn.workers.UvicornWorker -w 4 -b 127.0.0.1:8000