import argparse
from test import generate_sample_data

import uvicorn

from controllers.app import App

app = App()
api = app.api

def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('--docs', action='store_true')
    parser.add_argument('--test', action='store_true')
    parser.add_argument('--reset-db', action='store_true')
    parser.add_argument('--gen', action='store_true')
    return parser.parse_args()


def main():
    args = parse_args()
    if args.docs:
        app.generate_docs()
        return
    if args.reset_db:
        app.reset_db()
    if args.gen:
        print('Generating sample data')
        generate_sample_data(app)
    if not args.docs and not args.reset_db and not args.gen:
        uvicorn.run('main:api', port=8000)

if __name__ == '__main__':
    main()