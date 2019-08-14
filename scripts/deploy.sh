#!/bin/bash
if [ $? -eq 0 ]; then
  echo "Travis Branch: $TRAVIS_BRANCH"
  DEPLOY_BRANCH="master"

  if [ "$TRAVIS_BRANCH" == "$DEPLOY_BRANCH" ] && [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
    # Hot swap need to know what is the current version
    echo " :: Edeliver: Build"
    #mix edeliver build upgrade
    mix edeliver build release --branch=$DEPLOY_BRANCH

    if [ $? -eq 0 ]; then
      echo " :: [INFO] Successfully created build file!"

      echo " :: Edeliver: Deploy"
      #mix edeliver deploy upgrade
      mix edeliver deploy release --start-deploy --branch=$DEPLOY_BRANCH

      mix edeliver migrate
      
      exit 0
    else
      echo " :: [ERROR] Could not create file"
      exit 1
    fi
  fi
else
  echo "Failed build!"
  exit 1
fi