#!/bin/bash

IMAGE_NAME=${PWD##*/}
ECS_VERSION=$(aws ecr describe-images --repository-name $IMAGE_NAME --query 'sort_by(imageDetails,& imagePushedAt)[-1].imageTags' | jq 'join(" ")')
echo ${ECS_VERSION//latest/} | sed 's/ //g' | sed -e 's/^"//' -e 's/"$//'
