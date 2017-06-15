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
