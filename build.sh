#!/bin/bash

ELASTICSEARCH_VERSION=1.7.2
IMAGE_TAG="pitrho/elasticsearch"

# Custom die function.
#
die() { echo >&2 -e "\nRUN ERROR: $@\n"; exit 1; }

# Parse the command line flags.
#
while getopts "v:t:" opt; do
  case $opt in
    t)
      IMAGE_TAG=${OPTARG}
      ;;

    v)
      ELASTICSEARCH_VERSION=${OPTARG}
      ;;

    \?)
      die "Invalid option: -$OPTARG"
      ;;
  esac
done


rm -rf build
mkdir build
cp run.sh build/
#cp enable_backup.sh build/
#cp backup.sh build/
sed 's/%%ELASTICSEARCH_VERSION%%/'"$ELASTICSEARCH_VERSION"'/g' Dockerfile.tmpl > build/Dockerfile

docker build -t="${IMAGE_TAG}" build/

rm -rf build
