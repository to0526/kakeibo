From ruby:3.0.0-alpine3.13
RUN apk add build-base postgresql-dev yarn
RUN mkdir /app
WORKDIR /app
COPY ./Gemfile /app/Gemfile
COPY ./Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app
RUN yarn install --check-files
