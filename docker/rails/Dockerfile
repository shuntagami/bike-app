FROM ruby:2.6.5-alpine

WORKDIR /app

ENV RAILS_ENV="production"
ENV NODE_ENV="production"

# 依存パッケージのインストール
COPY Gemfile Gemfile.lock /app/
RUN apk add --no-cache -t .build-dependencies \
  build-base \
  libxml2-dev\
  libxslt-dev \
  && apk add --no-cache \
  zsh \
  vim \
  file \
  imagemagick \
  libpq \
  libxml2 \
  libxslt \
  nodejs \
  mysql-client \
  mysql-dev \
  tini \
  tzdata \
  yarn \
  && gem install bundler:2.0.2 \
  && bundle install \
  && apk del --purge .build-dependencies

# アプリケーションコードのコピー
COPY . /app

# アセットのプリコンパイル
RUN SECRET_KEY_BASE=placeholder bundle exec rails assets:precompile \
  && yarn cache clean \
  && rm -rf node_modules tmp/cache

ENV RAILS_SERVE_STATIC_FILES="true"
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
EXPOSE 3000