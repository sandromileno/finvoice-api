FROM ruby:3.0.1-alpine

WORKDIR /app

COPY . ./

RUN gem install bundler && \
apk update && \
apk add --no-cache --virtual build-dependencies build-base && \
apk add --no-cache --update sqlite-dev && \
apk add --no-cache git postgresql-dev postgresql-client && \
apk add --no-cache tzdata && \
rm -rf /var/cache/apk/*

RUN bundle install && chmod +x run_app.sh

CMD ["/app/run_app.sh"]