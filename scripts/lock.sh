#!/bin/bash
set -euxo pipefail

readonly root=$(realpath "$(git rev-parse --show-toplevel || echo .)")

docker build -f "$root"/docker/Dockerfile.bundle -t vbuf:bundle .
docker run --rm -v "$root"/blog:/blog -v "$root"/vendor:/vendor vbuf:bundle lock --update
