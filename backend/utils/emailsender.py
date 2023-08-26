import aiosmtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

async def send_html_email(
    sender: str,
    recipient: list[str],
    subject: str,
    content: str,
    hostname: str,
    port: int,
    username: str,
    password: str,
):

    message = MIMEMultipart('alternative')
    message['From'] = sender
    message['To'] = ', '.join(recipient)
    message['Subject'] = subject
    message.attach(MIMEText(content, 'plain', 'utf-8'))

    return await aiosmtplib.send(
        message=message,
        hostname=hostname,
        port=port,
        username=username,
        password=password,
        use_tls=True
    )
