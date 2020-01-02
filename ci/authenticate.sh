#!/bin/bash

. ci/configs/_config.conf

## Update Gcloud Components
gcloud components install core gsutil kubectl --quiet
gcloud components update --quiet

## Authenticate using proper service account for project/platform-create
gcloud auth activate-service-account "${accountName}" --key-file="${keyFilePath}" --project="${projectId}"

## Enable Necessary Services
gcloud services enable compute.googleapis.com
gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable dns.googleapis.com
gcloud services enable iam.googleapis.com

## Setting Project
gcloud config set project "${projectId}"

## Setting Project Zone
gcloud config set compute/zone "${defaultZone}"

## Setting Project Region
gcloud config set compute/region "${defaultRegion}"

gcloud compute project-info add-metadata --metadata enable-oslogin=TRUE
