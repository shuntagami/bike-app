FROM ruby:2.6.5

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /bike-app
ENV APP_ROOT /bike-app
WORKDIR $APP_ROOT

COPY ./Gemfile $APP_ROOT/Gemfile
COPY ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install

COPY . $APP_ROOT