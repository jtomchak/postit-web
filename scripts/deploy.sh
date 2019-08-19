#!/bin/bash
if [ $? -eq 0 ]; then
  echo "Travis Branch: $TRAVIS_BRANCH"
  DEPLOY_BRANCH="master"


  echo " :: Edeliver: Deploy"
  #mix edeliver deploy upgrade
  mix edeliver deploy release to production --start-deploy --branch=$TRAVIS_BRANCH
  
  exit 0
else
  echo " :: [ERROR] Could not create file"
  exit 1
fi

