FROM ruby:2.6.5

RUN apt-get update -qq && \
  apt-get install -y apt-utils \
  build-essential \
  libpq-dev \
  nodejs \
  vim \
  default-mysql-client 

WORKDIR /app

ADD Gemfile .
ADD Gemfile.lock .
RUN bundle install -j4
RUN RAILS_ENV=production bundle exec rake assets:precompile
ADD . /app

EXPOSE 3000

