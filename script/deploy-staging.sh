#!/bin/bash

set -ev
if [[ "$TRAVIS_BRANCH" == "master" ]]; then
  echo 'W($&^%(!*#&$(!*^#%$(&!#@^'
  bundler --version
  echo 'W($&^%(!*#&$(!*^#%$(&!#@^'
  wget -q -O cf-cli.deb https://cli.run.pivotal.io/stable?release=debian64
  sudo dpkg -i cf-cli.deb
  cf login -u $CF_USERNAME -p $CF_PASSWORD -o pivotallabs -s whiteboard -a https://api.run.pivotal.io
  echo 'W($&^%(!*#&$(!*^#%$(&!#@^'
  git diff
  echo 'W($&^%(!*#&$(!*^#%$(&!#@^'
  git checkout .
  bundle exec rake SPACE=whiteboard cf:deploy:staging
fi
