#!/bin/bash

input_path=$1
output_path=$2

for f in $(find $input_path -name '*')
do
  # Process markdown files exclusively.
  if test "x${f##*.}" = "xmd"; then

    #dirname=$(dirname -- "$f")
    filename=$(basename -- "$f")
    dirname=${f##*$input_path/}
    dirname=$(dirname -- "$dirname")
    filename="${filename%.*}"

    path="${output_path}/${dirname}"

    #echo -e "${path}"

    if [ ! -d "${path}" ]; then
      mkdir -p "${path}"
    fi

    o="${path}/${filename}.html"

    echo -e "${f} to ${o}"

    `pandoc -f markdown -t html5 $f -s -o $o --lua-filter=../links-to-html.lua`
  fi
done
