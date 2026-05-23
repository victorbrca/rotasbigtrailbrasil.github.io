#!/bin/bash

echo "Checking build zip"
if [ ! -f "../Build/production.zip" ] ; then
  echo "Could not find new build archive"
  exit 1
fi
echo "Extracting build"
unzip -q "../Build/production.zip" -d "../Build/production"

echo "Checking build dir"
if [ ! -f "../Build/production/index.html" ] ; then
  echo "Could not find new build"
  exit 1
fi

echo "Cleaning workdir"
trash-put ./*

echo "Copying build"
mv ../Build/production/* .

echo "Fixing files"
find . -type f -name '*.html' -exec sed -i \
  -e 's|nullrotasbigtrailbrasil|https://rotasbigtrailbrasil|g' \
  -e 's|http%3A%2F%2Flocalhost%3A10004|https%3A%2F%2rotasbigtrailbrasil.com.br|g' \
  -e 's|localhost:10004|rotasbigtrailbrasil.com.br|g' \
  -e 's|CHANGEME-AVISO-LEGAL|aviso-legal|' {} +

echo "Restoring CNAME"
cp ../CNAME .
sleep .5

echo "Adding files to repo"
git add .
sleep .5

echo "Commiting change"
git commit -m "$(date)"
sleep .5

echo "Pushing change"
git push
