import os


def get_password():
    return os.environ.get('GOOGLE_PASSWORD')


def get_email():
    return os.environ.get('GOOGLE_USER') + '@gmail.com'
