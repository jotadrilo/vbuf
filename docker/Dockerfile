FROM vbuf:bundle as vendor

COPY blog/Gemfile blog/Gemfile.lock /blog/
RUN bundle install

FROM ruby:3.1

ENV BUNDLE_PATH=/vendor/bundle
COPY --from=vendor $BUNDLE_PATH $BUNDLE_PATH

WORKDIR /blog
COPY blog /blog/

EXPOSE 4000

ENTRYPOINT ["bundle", "exec", "jekyll"]
CMD ["serve", "--host", "0.0.0.0"]
