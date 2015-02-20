#!/bin/sh
#
#   Publish gh-pages
#
cd ./bin/html5/
git clone git@github.com:darkoverlordofdata/alienzone-dart.git gh-pages
cd ./gh-pages/
git checkout gh-pages
git rm -rf .
cp -r ./.git ../bin
cd ../bin
git add . --all
git commit -m publish
git push origin gh-pages