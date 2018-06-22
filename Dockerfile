FROM ruby:2.4-slim

ARG GEM_NAME
# ARG GITHUB_TOKEN

ENV RAILS_ENV=docker-dev
ENV PACKAGES bash \
    build-essential \
    curl \
    gettext \
    git \
    libcurl4-openssl-dev \
    libpython-dev \
    openssh-server
ENV GEM_NAME_1=GEM_NAME

RUN apt-get update && \
    apt-get install --no-install-recommends -y wget && \
    apt-get update && \
    apt-get install --no-install-recommends -y $PACKAGES && \
    rm -rf /var/lib/apt/lists/*

RUN gem install bundler

RUN mkdir /usr/src/app
WORKDIR /usr/src/app

COPY . .

# RUN git config --global user.email "codeship-build@example.com"
# RUN git config --global user.name "Codeship-Bot"
# # RUN git remote set-url origin https://github.com/handysama/dummy-tag.git
# RUN git remote set-url origin https://handysama:${GITHUB_TOKEN}@github.com/handysama/dummy-tag.git
# # RUN git remote set-url origin git@github.com:handysama/dummy-tag.git

RUN echo "test echo here"
RUN echo GEM_NAME

# RUN git tag -a v1.0.9 -m "[skip ci]"
# RUN git tag
# RUN git push origin --tags

# RUN git config --global credential.helper cache
# CMD ["git push origin --tags"]
