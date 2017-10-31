#!/usr/bin/env bash

# To be used for deployment after a successful build

currentDate="$(date +%F)"

fileName="my-project-${currentDate}.zip"

scp my-project.zip "production:/home/jenkins/ci/$fileName"

ssh -A production 'bash -s' < production-server-deploy.sh

