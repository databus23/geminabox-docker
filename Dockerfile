FROM ruby:2.4-alpine

LABEL source_repository=https://github.com/databus23/geminabox-docker

WORKDIR /app

COPY Gemfile Gemfile

COPY Gemfile.lock Gemfile.lock

RUN \
  echo 'gem: --no-document' >> ~/.gemrc && \
  apk --update add --virtual build_deps build-base linux-headers openssl-dev && \
  bundle install --jobs=4 && \
  bundle clean --force && \
  apk del  build_deps

COPY . .

ENTRYPOINT ["/app/entrypoint.sh"]
