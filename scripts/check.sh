#!/bin/bash -ex

if [ "$#" -ne 1 ]
then
  echo "Usage: check <production|staging>"
  exit 1
fi

_environment="$1"

if [ "$_environment" = "production" ]; then
  mix edeliver version production
  mix edeliver ping production
fi

if [ "$_environment" = "staging" ]; then
  mix edeliver version production --mix-env=staging
  mix edeliver ping staging --mix-env=staging
fi
