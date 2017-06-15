FROM jekyll:latest

WORKDIR /src

COPY Gemfile /src

ENV BUNDLE_PATH=/vendor/bundle
RUN bundle install
