# syntax=docker/dockerfile:1
FROM python:3.11-slim
ENV PYTHONUNBUFFERED 1
ENV LANG ru_RU.UTF-8

RUN apt-get update &&  \
    apt-get install --no-install-recommends -y \
    curl \
    git \
    gettext \
    binutils \
    libproj-dev \
    libjpeg-dev \
    build-essential \
    libpng-dev \
    libpq-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*


WORKDIR /usr/src/app
COPY ./requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt


WORKDIR /code
COPY . /code

RUN chmod +x /code/.dockerinit.sh
CMD [ "/code/sh_scripts/.dockerinit.sh" ]
EXPOSE 8000
