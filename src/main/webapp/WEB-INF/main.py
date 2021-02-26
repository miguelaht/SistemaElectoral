#!/usr/bin/env python3
import sys
import smtplib
import string
import os
from dotenv import load_dotenv
import random

load_dotenv()

EMAIL_ADDRESS = str(os.getenv('EMAIL_USER'))
EMAIL_PASSWORD = str(os.getenv('EMAIL_PASS'))
EMAIL_RECEIVER = str(sys.argv[1])

def generate()-> str:
    characters = string.ascii_letters + string.digits + "@()#!$%&^*"
    password =  "".join(random.choice(characters) for _ in range(8))
    return password

with smtplib.SMTP('smtp.gmail.com', 587) as smtp:
    smtp.ehlo()
    smtp.starttls()
    smtp.ehlo()

    smtp.login(EMAIL_ADDRESS, EMAIL_PASSWORD)

    subject = 'Sistema Electoral'
    code = generate()
    body = f'Tu clave de acceso es: {code}.\n\n Utilizala con cuidado.'

    msg = f'Subject: {subject}\n\n{body}'

    smtp.sendmail(EMAIL_ADDRESS, EMAIL_RECEIVER, msg)
    print(code)
