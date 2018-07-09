#!/bin/bash

output=docset

if [ ! -d "${output}" ]; then
  mkdir -p "${output}"
fi

rm -rf "${output}/*"

cp dashing.json "${output}/"
cp mesos.css "${output}/"

./markdown2html.sh ../mesos-private/docs "${output}"

cd "${output}"
dashing build "Apache Mesos"
cd ..
