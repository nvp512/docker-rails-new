FROM ruby:2.6.0-slim as base
ENV LANG C.UTF-8

RUN apt-get update \
  && apt-get install -y --no-install-recommends build-essential git vim libpq-dev imagemagick libtag1-dev ffmpeg \
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false

WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp

EXPOSE 3000
# CMD ["tail", "-f", "/dev/null"]
