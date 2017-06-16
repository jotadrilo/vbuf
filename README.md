# VBUF

VBUF blog based on [Jekyll](https://jekyllrb.com) and [GitHub Pages](https://pages.github.com)

## Update Jekyll dependencies

Docker based:

```
docker build -t jekyll:latest -f docker/Dockerfile.jekyll .
docker build -t vbuf:latest -f docker/Dockerfile .
docker-compose -f docker/docker-compose.yml run bundle
```

The `Gemfile.lock` file will be updated afterwards.

## Create a Jekyll scoldfolder

```
docker run -v `pwd`:/src jekyll:latest new /src --force
docker-compose -f docker/docker-compose.yml run bundle
```

## Deploy blog

```
docker-compose -f docker/docker-compose.yml up vbuf
```

## Exclude vendor folder

If you get an error like this:

```
vbuf_1    |       Generating...
vbuf_1    |              ERROR: YOUR SITE COULD NOT BE BUILT:
vbuf_1    |                     ------------------------------------
vbuf_1    |                     Invalid date '<%= Time.now.strftime('%Y-%m-%d %H:%M:%S %z') %>': Document 'vendor/bundle/gems/jekyll-3.4.3/lib/site_template/_posts/0000-00-00-welcome-to-jekyll.markdown.erb' does not have a valid date in the YAML front matter.
```

Then, Jekyll is trying to render wrong files (note the `vendor/bundle/gems...` path). Make sure that the `_config.yml` file excludes those files and folders:

```
exclude:
  ...
  - vendor
```
