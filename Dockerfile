FROM ruby:2.4-alpine

WORKDIR /app

COPY Gemfile Gemfile

COPY Gemfile.lock Gemfile.lock

RUN \
  echo 'gem: --no-document' >> ~/.gemrc && \
  apk --update add --virtual build_deps build-base linux-headers openssl-dev && \
  bundle install --jobs=4 && \
  bundle clean && \
  apk del  build_deps

COPY . .

ENTRYPOINT ["/app/entrypoint.sh"]
