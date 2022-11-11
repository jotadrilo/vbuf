#!/bin/bash
set -euxo pipefail

readonly root=$(realpath "$(git rev-parse --show-toplevel || echo .)")

docker run --rm -v "$root"/blog:/blog -v "$root"/vendor:/vendor  -v "$root"/dist:/dist -v "$root"/scripts:/scripts --entrypoint=/scripts/dist.sh vbuf:latest -s /blog -d /dist -b /vendor/bundle
