#!/bin/bash
set -e

rm -rf _build
for filename in $(ls -1 ./src/images/*.excalidraw); do filename="${filename%.excalidraw}"; rm -f $filename.png; done
excalidraw-cli
jupyter-book start &
while inotifywait -r -e modify ./myst.yml; do
  pid=$(jobs -p %1)
  kill ${pid}
  rm -rf _build
  for filename in $(ls -1 ./src/images/*.excalidraw); do filename="${filename%.excalidraw}"; rm -f $filename.png; done
  excalidraw-cli
  jupyter-book start &
done
