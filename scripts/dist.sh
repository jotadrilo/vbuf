#!/bin/bash
set -eo pipefail

src=
dst=
bundle=/tmp/vendor/bundle

help() {
  echo ""
  echo "Usage: $0 [Options]"
  echo ""
  echo "Options:"
  echo "  -s | --source       Source blog directory (default: $src)"
  echo "  -d | --destination  Destination blog directory (default: $dst)"
  echo "  -b | --bundle       Bundle directory (default: $bundle)"
  echo "  -h | --help   Show this help page."
  echo ""
  exit 0
}

while [[ $# -gt 0 ]]; do
  case "$1" in
  -s | --source)
    shift
    src=$1
    shift
    ;;
  -d | --destination)
    shift
    dst=$1
    shift
    ;;
  -b | --bundle)
    shift
    bundle=$1
    shift
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

if [[ ! -d "$src" ]]; then >&2 echo "Source folder does not exist"; exit 1; fi

export BUNDLE_PATH=$bundle

mkdir -p "$dst"
cp -pr "$src"/* "$dst"
cd "$dst"

gem install html-proofer
bundle install
bundle exec jekyll build
ln -sf . _site/vbuf
htmlproofer ./_site
rm _site/vbuf
rm -rf .jekyll-cache Gemfile*
