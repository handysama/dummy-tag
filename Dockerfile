FROM ruby:2.4-slim

# build-essential required for make/fcc/g++ (mostly for GEM native extensions)
# curl is added so we can use the `curl` command in our scripts
# gettext required for envsubst command
# git required for git install of GEMs
# libcurl4-openssl-dev required for `curb` GEM install
# libpq-dev required for `pg` GEM install
# nodejs required to load `uglifier` gem
# postgres client required for db migration/tests
# pip required for AWS CLI install
ENV PACKAGES bash \
    build-essential \
    curl \
    gettext \
    git \
    libcurl4-openssl-dev \
    libpq-dev \
    libpython-dev \
    nodejs \
    postgresql-client \
    python-pip \
    redis-tools

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
