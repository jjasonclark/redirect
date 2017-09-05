FROM ruby:2.4-alpine

# Setup dependencies
RUN apk update && apk add --no-cache \
    tzdata \
    build-base \
    postgresql-dev

# Setup the redirecter directory
RUN mkdir -p /app
WORKDIR /app

# Expose the port for our rails server
EXPOSE 80
