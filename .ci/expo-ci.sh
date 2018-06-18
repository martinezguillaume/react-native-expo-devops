#!/bin/bash

# Configure user
git config --global user.name "Martinez"
echo -e "machine github.com\n login martinezguillaume\n password $GITHUB_TOKEN" >> ~/.netrc

# Expo auto deployment for PRs
if [ "$TRAVIS_PULL_REQUEST" != "false" -a "$TRAVIS_PULL_REQUEST_SLUG" == "martinezguillaume/react-native-expo-devops" ]; then
  set -x

  # Clone example app and install modules
  yarn add "https://github.com/${TRAVIS_PULL_REQUEST_SLUG}.git#${TRAVIS_PULL_REQUEST_SHA}"
  yarn
  yarn global add exp

  # Login into expo and publish the example app
  set +x
  exp login -u "$EXPO_LOGIN" -p "$EXPO_PASSWORD"  --non-interactive
  set -x
  exp publish --release-channel ${TRAVIS_PULL_REQUEST_SHA}

  # Comment the PR
  pwd
  cd ./.ci
  yarn
  node index.js
fi
