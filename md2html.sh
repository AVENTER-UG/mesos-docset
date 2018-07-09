#!/bin/bash

set -e

input_path=$1
output_path=$2

for f in $(find $input_path -name '*')
do
  # Process markdown files exclusively.
  if test "x${f##*.}" = "xmd"; then
    dirname=${f##*$input_path/}
    dirname=$(dirname -- "$dirname")

    filename=$(basename -- "$f")
    filename="${filename%.*}"

    path="${output_path}/${dirname}"

    if [ ! -d "${path}" ]; then
      mkdir -p "${path}"
      cp mesos.css "${path}/"
    fi

    o="${path}/${filename}.html"

    echo -e "${f} to ${o}"

    `pandoc -c mesos.css -f markdown -s -t html5 $f -o $o --lua-filter=links-to-html.lua`
  fi
done
