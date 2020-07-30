From ruby:2.7.1-alpine3.12
RUN apk add build-base postgresql-dev yarn
COPY ./Gemfile /Gemfile
COPY ./Gemfile.lock /Gemfile.lock
RUN bundle install
COPY . /
RUN yarn install --check-files
