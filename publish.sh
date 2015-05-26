#!/bin/sh
#
#   Publish gh-pages
#

cp -fr ./bin/html5/bin ./html5/
cd ./html5/
git clone git@github.com:darkoverlordofdata/alienzone-haxe.git gh-pages
cd ./gh-pages/
git checkout gh-pages
git rm -rf .
cp -r ./.git ../web
cd ../web
git add . --all
git commit -m publish
git push origin gh-pages
rm -fr ./.git
cd ..
rm -fr ./gh-pages