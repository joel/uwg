FROM ruby:3.0.0-alpine3.13

LABEL maintener='joel.azemar@gmail.com'
LABEL com.example.version="0.0.1-beta"
LABEL vendor="ACME Incorporated"
LABEL com.example.release-date="2021-03-08"

# Minimal requirements to run a Rails app
RUN apk add --no-cache --update build-base \
  linux-headers \
  git \
  postgresql-dev=~13 \
  # Rails SQL schema format requires `pg_dump(1)` and `psql(1)`
  postgresql=~13 \
  # Install same version of pg_dump
  postgresql-client=~13 \
  nodejs \
  yarn \
  tzdata

ENV BUNDLER_VERSION 2.2.11
ENV BUNDLE_PATH /bundle
ENV GEM_HOME /bundle
ENV BUNDLE_JOBS 20
ENV BUNDLE_RETRY 5
ENV BUNDLE_WITHOUT production
ENV BUNDLE_CACHE_ALL true
ENV RAILS_ENV development
ENV RACK_ENV development
ENV APP_PATH /work

WORKDIR $APP_PATH

COPY Gemfile $APP_PATH
COPY Gemfile.lock $APP_PATH

RUN gem install bundler -v $BUNDLER_VERSION

ENTRYPOINT ["./docker-entrypoint.sh"]