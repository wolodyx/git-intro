#!/bin/bash

function BuildBook() {
  excalidraw-cli
  jupyter-book build .
  for filename in $(ls -1 ./src/images/*.excalidraw); do filename="${filename%.excalidraw}"; rm -f $filename.png; done
}

rm -rf _build
BuildBook
while inotifywait -r -e modify ./src intro.md _toc.yml _config.yml; do
  BuildBook
done

