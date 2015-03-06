#/bin/bash

CLONE_URL=https://github.com/AWSTrainers/devops-aws.git
ENV_ID="devops-build-$(date +"%Y-%m-%d-%H-%M-%S")"
ENV_DIR="$HOME/devops/$ENV_ID"

echo "### Starting Deployment $ENV_DIR"
mkdir -p $ENV_DIR
cd $ENV_DIR

echo "### Cloning Repo"
git clone $CLONE_URL 

echo "### Publishing Static Content"
ENV_BUCKET="s3://$ENV_ID"
echo "Creating Bucket"
aws s3 mb $ENV_BUCKET

ENV_STATICS=$ENV_DIR/quest01/public/
echo "[$ENV_STATICS]=>[$ENV_BUCKET]"
aws s3 sync $ENV_STATICS $ENV_BUCKET

echo "### Setting public read policy"
S3POL_PRE='{"Version":"2012-10-17","Statement":[{"Sid":"AddPerm","Effect":"Allow","Principal": "*","Action":["s3:GetObject"],"Resource":["arn:aws:s3:::'
S3POL_POS='/*"]}]}'
S3POL="$S3POL_PRE$ENV_ID$S3POL_POS"
echo $S3POL >> $ENV_DIR/bucket_policy.json
aws s3api put-bucket-policy --bucket $ENV_ID  --policy file://$ENV_DIR/bucket_policy.json

echo "### Configuring Website"
aws s3api put-bucket-website --bucket $ENV_ID --website-configuration '{"IndexDocument":{"Suffix":"index.html"}}'

echo "### New Environment Up!"
echo "http://${ENV_ID}.s3-website-us-east-1.amazonaws.com/"
