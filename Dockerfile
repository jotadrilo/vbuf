FROM jekyll:latest

WORKDIR /src

COPY src/Gemfile /src

ENV BUNDLE_PATH=/vendor/bundle
RUN bundle install
