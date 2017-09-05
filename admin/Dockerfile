FROM ruby:2.4-alpine

# Setup dependencies
RUN apk update && apk add --no-cache \
    nodejs \
    tzdata \
    build-base \
    postgresql-dev

RUN npm i -g yarn

# Setup the admin directory
RUN mkdir -p /admin
WORKDIR /admin

# Expose the port for our rails server
EXPOSE 3000

CMD bin/rails s -b 0.0.0.0 -p 3000
