#!/bin/bash

set -e

function run_integration_tests() {
  echo RUNNING INTEGRATION TESTS
}

function deploy() {
  echo DEPLOYING
}

function run_system_tests() {
  echo RUNNING SYSTEM TESTS
}

if [ ! -z "$DRONE_PR" ]; then
  # don't do a full pipeline for pull requests!!!!!!!!!!!!!!!
  run_integration_tests
  exit 0
fi

git remote add pipeline git@github.com:vito/drone-pipeline-spike.git

case "$DRONE_BRANCH" in
  develop)
    run_integration_tests
    git push pipeline HEAD:refs/heads/deploy
    ;;
  deploy)
    deploy
    git push pipeline HEAD:refs/heads/system-tests
    ;;
  system-tests)
    run_system_tests
    git push pipeline HEAD:refs/heads/master
    ;;
esac
