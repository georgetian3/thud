import json
from controllers.app import App
from fastapi.testclient import TestClient
import requests
import random

def random_letters(n):
    letters = 'ABCDEFGHIJKLMNOPQRSTUVQXYZabcdefghijklmnopqrstuvwxyz0123456789'
    return ''.join([random.choice(letters) for _ in range(n)])

def pr(resp):
    print(resp.status_code, resp.content)


def generate_sample_data(app: App):

    r = tuple(range(1, 4))

    users = {
        f'user{i}': {
            'password': 'secret123',
            'pfp': f'https://picsum.photos/seed/{i}/512',
            'bio': '[{"insert": "你好！我是 user' + str(i) +'\\n"}]',
            'post': {
                'title': f'用户 {i} 的动态标题 ' + random_letters(10),
                'content': '[{"insert": "' + f'用户 {i} 的动态内容' + random_letters(10) + '\\n"}]',
                'tags': [random_letters(5) for _ in range(5)],
                'id': 0,
            },
            'token': None
        } for i in r
    }

    likes = (
        (2, 1),
        (3, 1),
        (1, 2),
    )

    saves = (
        (1, 2),
        (1, 3),
        (2, 1),
        (3, 2),
    )

    comments = (
        (2, 2),
        (1, 3),
        (2, 3),
        (1, 2),
    )

    follows = (
        (2, 1),
        (1, 3),
        (2, 3),
        (1, 2),
    )

    client = TestClient(app.api)


    for i in r:
        username = f'user{i}'
        user = users[username]
        register = client.put('/register',
            json={
                'username': username,
                'password': user['password']
            }
        )
        pr(register)
        token = client.post('/login',
            data={
                'username': username,
                'password': user['password']
            }
        )
        token = {'Authorization': f'Bearer {json.loads(token.content.decode())["access_token"]}'}
        user['token'] = token
        client.patch('/users/me/profile-picture',
            headers=token,
            files={'profile_picture': (f'pfp{i}', requests.get(user['pfp']).content)}
        )

        client.patch('/users/me/bio',
            headers=token,
            json={'bio': user['bio']}
        )

        post = client.put('/posts',
            headers=token,
            json=user['post']
        )
        pr(post)
        post_id = json.loads(post.content)['post']
        user['post']['id'] = post_id

    print(users)

    for like in likes:
        resp = client.patch('/posts/' + str(users[f'user{like[1]}']['post']['id']) + '/like',
            headers=users[f'user{like[0]}']['token']
        )

    for save in saves:
        resp = client.patch('/posts/' + str(users[f'user{save[1]}']['post']['id']) + '/save',
            headers=users[f'user{save[0]}']['token']
        )

    for comment in comments:
        resp = client.put('/posts/' + str(users[f'user{comment[1]}']['post']['id']) + '/comments',
            headers=users[f'user{comment[0]}']['token'],
            json={'content': ' '.join(random_letters(10) for _ in range(10))}
        )

    for follow in follows:
        resp = client.post('/users/id/' + str(follow[1]) + '/follow',
            headers=users[f'user{follow[0]}']['token'],
        )
        pr(resp)
