FROM ruby:2.4-slim

ENV RAILS_ENV=docker-dev

ENV PACKAGES bash \
    build-essential \
    curl \
    gettext \
    git \
    libcurl4-openssl-dev \
    libpython-dev \
    openssh-server

# postgres 9.5 currently in testing only in debian repo
# see https://packages.debian.org/search?suite=default&section=all&arch=any&searchon=names&keywords=postgresql-client
RUN apt-get update && \
    apt-get install --no-install-recommends -y wget && \
    echo 'deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main' >> /etc/apt/sources.list && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    apt-get update && \
    apt-get install --no-install-recommends -y $PACKAGES && \
    rm -rf /var/lib/apt/lists/*

RUN gem install bundler

RUN mkdir /usr/src/app
WORKDIR /usr/src/app

COPY . .

CMD ["printenv"]

RUN git status
