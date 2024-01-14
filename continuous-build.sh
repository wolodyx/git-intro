#!/bin/bash

while inotifywait -r -e modify ./src intro.md _toc.yml _config.yml; do
  jupyter-book build .
done

