def location_inner(text: str) -> str:
    lines = text.split('\n')
    for i in range(14, 26):
        lines[i] = '//' + lines[i]
    return '\n'.join(lines)

def put_media(text: str) -> str:
    lines = text.split('\n')
    for i in range(56, 59):
        lines[i] = '//' + lines[i]
    lines.insert(56, 'return null;\n')
    return '\n'.join(lines)

def user(text: str) -> str:
    text = text.replace(': const {}', ': {}')
    return text

def post(text: str) -> str:
    text = text.replace(': const {}', ': {}')
    return text

def profile_picture(text: str) -> str:
    lines = text.split('\n')
    for i in range(56, 59):
        lines[i] = '//' + lines[i]
    lines.insert(56, 'return null;\n')
    return '\n'.join(lines)

def api_client(text: str) -> str:
    text = text.replace('growable: growable', 'growable: true')
    return text

def comment(text: str) -> str:
    text = text.replace('growable: growable', 'growable: true')
    return text

def api_helper(text: str) -> str:
    text = text.replace(
        'DateTime.tryParse(value)',
        'DateTime.tryParse(value)?.add(DateTime.now().timeZoneOffset)'
    )
    return text

files = {
    '../app/lib/api/lib/model/location_inner.dart': location_inner,
    '../app/lib/api/lib/model/body_put_media_media_media_id_put.dart': put_media,
    '../app/lib/api/lib/model/body_change_profile_picture_users_me_profile_picture_patch.dart': profile_picture,
    '../app/lib/api/lib/model/user.dart': user,
    '../app/lib/api/lib/model/post.dart': post,
    '../app/lib/api/lib/model/comment.dart': comment,
    '../app/lib/api/lib/api_client.dart': api_client,
    '../app/lib/api/lib/api_helper.dart': api_helper,
}

for file in files:
    try:
        with open(file) as f:
            text = f.read()
        text = files[file](text)
        with open(file, 'w') as f:
            f.write(text)
    except Exception as e:
        print(f'Exception for file {file}: {e}')