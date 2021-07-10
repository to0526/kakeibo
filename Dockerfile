From ruby:3.0.2-alpine3.13
RUN apk add build-base postgresql-dev yarn shared-mime-info
RUN mkdir /app
WORKDIR /app
COPY ./Gemfile /app/Gemfile
COPY ./Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app
RUN yarn install --check-files
