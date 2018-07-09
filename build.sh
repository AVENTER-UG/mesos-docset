#!/bin/bash

set -e

project="Apache Mesos"

if [[ $# -eq 0 ]] ; then
    echo "Missing path to ${project} project root folder."
    echo "Example:"
    echo "  ${0} ../mesos"
    exit 1
fi

input=$1/docs
output=docset

if [ ! -d "${output}" ]; then
  mkdir -p "${output}"
fi

echo "# cleaning up..."
rm -rf "${output}/*"

echo "# preparing..."
cp dashing.json "${output}/"
cp mesos.css "${output}/"
cp -R "${input}/images" "${output}/"

echo "# converting markdown to html..."
./md2html.sh "${input}" "${output}"

echo "# building docset..."
cd "${output}"
dashing build "${project}"
cd ..

echo "# adding icon..."
cp icon.png "${output}/${project}.docset/icon.png"
cp icon@2x.png "${output}/${project}.docset/icon@2x.png"

echo "# done!"
