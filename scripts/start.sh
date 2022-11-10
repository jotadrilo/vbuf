#!/bin/bash
set -eo pipefail

readonly root=$(realpath "$(git rev-parse --show-toplevel || echo .)")

local=false
trace=false
incremental=false

help() {
  echo ""
  echo "Usage: $0 [Options]"
  echo ""
  echo "Options:"
  echo "  -l | --local  Use local blog (default: $local)"
  echo "  -h | --help   Show this help page."
  echo ""
  echo "Jekyll Options:"
  echo "  --trace       Enable trace Jekyll option (default: $trace)"
  echo "  --incremental Enable incremental Jekyll option (default: $incremental)"
  echo ""
  exit 0
}

while [[ $# -gt 0 ]]; do
  case "$1" in
  -l | --local)
    shift
    local=true
    ;;
  --trace)
    shift
    trace=true
    ;;
  --incremental)
    shift
    incremental=true
    ;;
  -h | --help)
    shift
    help
    ;;
  *)
    echo >&2 "unknown \"$1\" option."
    exit 1
    ;;
  esac
done

jekyll_args=("serve" "--host" "0.0.0.0")
if [[ "$trace" == "true" ]]; then jekyll_args+=("--trace"); fi
if [[ "$incremental" == "true" ]]; then jekyll_args+=("--incremental"); fi

docker_args=()
if [[ "$local" == "true" ]]; then docker_args+=("-v" "${root}/blog:/blog"); fi

if [[ "$trace" == "true" ]]; then set -x; fi

docker run -p 4000:4000 "${docker_args[@]}" vbuf:latest "${jekyll_args[@]}"
