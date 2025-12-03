# picobox for use ruby and nodejs
#
# VERSION               0.1.0

# Change this for different versions of ruby (see https://hub.docker.com/_/ruby/)
# FROM ruby:2.2-slim
# FROM ruby:2.3-slim

FROM ruby:slim-bookworm

ENV APP_HOME /var/www
ENV PATH $APP_HOME/bin:$PATH
ENV NODE_MAJOR=20

# silence deb warnings
ENV DEBIAN_FRONTEND noninteractive

# do install here
RUN mkdir -p /tmp
WORKDIR /tmp

# add repository software
RUN apt-get update
RUN apt-get install -y build-essential software-properties-common tzdata wget curl gnupg2

## Languages

# nodejs
# node + yarn install (node is required for rails to run)
RUN printf 'Package: nodejs\nPin: origin deb.nodesource.com\nPin-Priority: 1001' > /etc/apt/preferences.d/nodesource \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
    && apt-get update -qq && apt-get install -qq --no-install-recommends nodejs

# utils
RUN apt-get install -y vim nano git

# make nano work
RUN echo "export TERM=xterm" >> /etc/bash.bashrc

# working dir
WORKDIR $APP_HOME

# add gemfile
ONBUILD ADD Gemfile* $APP_HOME/

# hook up source
ONBUILD ADD . $APP_HOME
