#!/bin/bash

set -ev

if [[ "$TRAVIS_BRANCH" == "master" ]]; then
  wget -q -O cf-cli.deb https://cli.run.pivotal.io/stable?release=debian64
  sudo dpkg -i cf-cli.deb
  cf login -u $CF_USERNAME -p $CF_PASSWORD -o pivotallabs -s whiteboard -a https://api.run.pivotal.io
  git status
  git checkout .
  cf set-env whiteboard-acceptance OKTA_SSO_TARGET_URL $OKTA_SSO_TARGET_URL
  cf set-env whiteboard-acceptance OKTA_CERT_FINGERPRINT $OKTA_CERT_FINGERPRINT
  bundle exec rake SPACE=whiteboard cf:deploy:staging
fi
