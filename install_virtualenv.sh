#!/bin/bash
if [ $# -eq 0 ]
then
  BRANCH="master"
else
  BRANCH=$1
fi

./get_from_github.sh $BRANCH

./install_dev_venv.sh

