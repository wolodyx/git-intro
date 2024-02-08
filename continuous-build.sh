#!/bin/bash

rm -rf _build
jupyter-book build .

while inotifywait -r -e modify ./src intro.md _toc.yml _config.yml; do
  jupyter-book build .
done

