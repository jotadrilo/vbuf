FROM ruby:3.1 as vendor

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y --no-install-recommends nodejs && \
    rm -r /var/lib/apt/lists /var/cache/apt/archives

WORKDIR /blog
COPY blog/Gemfile blog/Gemfile.lock /blog/

ENV BUNDLE_PATH=/vendor/bundle
RUN bundle install

FROM ruby:3.1

ENV BUNDLE_PATH=/vendor/bundle
COPY --from=vendor $BUNDLE_PATH $BUNDLE_PATH

WORKDIR /blog
COPY blog /blog/

EXPOSE 4000

ENTRYPOINT ["bundle", "exec", "jekyll"]
CMD ["serve", "--host", "0.0.0.0"]
