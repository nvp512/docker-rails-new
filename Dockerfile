FROM ruby:2.6
ENV LANG C.UTF-8

RUN apt-get update \
  && apt-get install -y --no-install-recommends build-essential git vim libpq-dev imagemagick libtag1-dev ffmpeg \
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false

#Install Yarn - For webpacker on Rails 6.0
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y nodejs yarn

WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp

EXPOSE 3000
# CMD ["tail", "-f", "/dev/null"]
