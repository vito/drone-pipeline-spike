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

git remote add deploy git@github.com:vito/drone-pipeline-spike.git

case "$DRONE_BRANCH" in
  master)
    run_integration_tests
    git push deploy passed-integration
    ;;
  passed-integration)
    deploy
    git push deploy passed-deploy
    ;;
  passed-deploy)
    run_system_tests
    ;;
esac
