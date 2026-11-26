#!/bin/bash

find . -name "*.qml" -exec grep -l "pragma Singleton" {} + | xargs -n1 dirname | sort -u | while read -r dir; do
  mod="qs$(echo "${dir#.}" | tr '/' '.')"
  echo "module $mod" > "$dir/qmldir"
  grep -l "pragma Singleton" "$dir"/*.qml | while read -r f; do
    base=$(basename "$f" .qml)
    echo "singleton $base 1.0 $base.qml" >> "$dir/qmldir"
  done
  echo "Generated $dir/qmldir"
done
