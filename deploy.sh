#!/bin/bash -x
export APP_VERSION=`git rev-parse --short HEAD`
#export APP_VERSION="$(./codenames/name.sh)"


if [[ ${CI_BRANCH} == "master" ]]
then
    deploy_env="prod"
#    echo "Automated builds are not supported for production, it's too scary!!!"
#    exit 0
else
    deploy_env=${CI_BRANCH}
fi

if [[ ${deploy_env} == prod ]]
then
        channel="#ops"
else
        channel="#dev"
fi

pip install awscli

# clean build artifacts and create the application archive (also ignore any files named .git* in any folder)
# precompile assets, ...

# delete any version with the same name (based on the short revision)
aws elasticbeanstalk delete-application-version --application-name "snapito-logstash" --version-label "${APP_VERSION}"  --delete-source-bundle


 zip app.zip *
# upload to S3
aws s3 cp app.zip s3://${S3_BUCKET}/logstash-${APP_VERSION}.zip

# create a new version and update the environment to use this version
aws elasticbeanstalk create-application-version --application-name "snapito-logstash" --version-label "${APP_VERSION}" --source-bundle S3Bucket="${S3_BUCKET}",S3Key="logstash-${APP_VERSION}.zip"

aws elasticbeanstalk update-environment --environment-name "snapito-logstash-${deploy_env}" --version-label "${APP_VERSION}"

curl -X POST --data-urlencode "payload={\"channel\": \"$channel\", \"username\": \"Release Bot\", \"text\": \"Release ${APP_VERSION} of logstash deployed to ${deploy_env} \", \"icon_emoji\": \":smile:\"}" https://cazcade.slack.com/services/hooks/incoming-webhook?token=HNBKLpzjteDVpwmqRnosNWMu
