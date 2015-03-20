FROM ruby:2.2.1
RUN apt-get update -qq && apt-get install -y build-essential nodejs npm nodejs-legacy libpq-dev

RUN mkdir /docker_app

WORKDIR /tmp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

ADD . /docker_app
WORKDIR /docker_app
ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true
EXPOSE 9292
RUN bundle exec rake assets:precompile
CMD ["bundle", "exec", "puma", "-t", "8:16", "-e", "production"]

