ENVIRONMENT=${1:-dev}
. .env.$ENVIRONMENT

cd ../app

docker build -t $AWS_ECR_REPOSITORY/$APP_NAME:$APP_VERSION .
aws ecr get-login-password --profile $AWS_PROFILE | docker login --username AWS --password-stdin $AWS_ECR_REPOSITORY
docker push $AWS_ECR_REPOSITORY/$APP_NAME:$APP_VERSION

cd ../scripts