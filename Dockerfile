FROM python:3.7-alpine
MAINTAINER Vicente Guerrero

# Recommended for python un docker images
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
# permanent dependancies. allows psycopg2 to run
RUN apk add --update --no-cache postgresql-client
# temporal packages before installing requirements.txt
RUN apk add --update --no-cache --virtual .tmp-build-deps \
        gcc libc-dev linux-headers postgresql-dev
RUN pip install -r /requirements.txt
run apk del .tmp-build-deps

# Setup directory structure. Applications will start from here
RUN mkdir /app
WORKDIR /app  
COPY ./app /app


RUN adduser -D user  # User for running applications and process. For security purposes
USER user
