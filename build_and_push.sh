#!/usr/bin/env bash

imgname=$1

if [ "$imgname" == "" ]
then
    echo "Usage: $0 <image-name>"
    exit 1
fi

account=$(aws sts get-caller-identity --query Account --output text)

if [ $? -ne 0 ]
then
    exit 255
fi


region=$(aws configure get region)
region=${region:-us-west-2}


ecr_repo="${account}.dkr.ecr.${region}.amazonaws.com/${imgname}:latest"

aws ecr describe-repositories --repository-names "${imgname}" > /dev/null 2>&1

if [ $? -ne 0 ]
then
    aws ecr create-repository --repository-name "${imgname}" > /dev/null
fi

$(aws ecr get-login --region ${region} --no-include-email)

docker build  -t ${imgname} .
docker tag ${imgname} ${ecr_repo}

docker push ${ecr_repo}
