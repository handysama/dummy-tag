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

RUN git status
RUN git config --global user.email "codeship-build@example.com"
RUN git config --global user.name "Codeship-bot"
RUN git remote set-url origin https://github.com/handysama/dummy-tag.git
# RUN git remote set-url origin git@github.com:handysama/dummy-tag.git

RUN git tag -a v1.0.1 -m "tag from codeship"
RUN git tag
# RUN git push origin --tags

CMD ["git push origin --tags"]
