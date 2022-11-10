#!/bin/bash
set -euxo pipefail

readonly root=$(realpath "$(git rev-parse --show-toplevel || echo .)")

docker build -f "$root"/docker/Dockerfile -t vbuf:latest .
