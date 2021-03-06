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

RUN apt-get update && \
    apt-get install --no-install-recommends -y wget && \
    apt-get update && \
    apt-get install --no-install-recommends -y $PACKAGES && \
    rm -rf /var/lib/apt/lists/*

RUN gem install bundler

RUN mkdir /usr/src/app
WORKDIR /usr/src/app

COPY . .
COPY test_echo.sh test_echo.sh

# RUN git config --global user.email "codeship-build@example.com"
# RUN git config --global user.name "Codeship-Bot"
# # RUN git remote set-url origin https://github.com/handysama/dummy-tag.git
# RUN git remote set-url origin https://handysama:${GITHUB_TOKEN}@github.com/handysama/dummy-tag.git
# # RUN git remote set-url origin git@github.com:handysama/dummy-tag.git

RUN echo "test echo here"
RUN echo $EXAMPLE_ENV_VAR
RUN echo $GEM_NAME
RUN echo $CI_REPO_NAME
RUN echo $CI_COMMIT_ID

# RUN git tag -a v1.0.9 -m "[skip ci]"
# RUN git tag
# RUN git push origin --tags

# RUN git config --global credential.helper cache
# CMD ["git push origin --tags"]
