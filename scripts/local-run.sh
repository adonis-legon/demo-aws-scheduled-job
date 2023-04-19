ENVIRONMENT=$1
ALGORITHM=${2:-PRIMES}

. .env.$ENVIRONMENT

docker run -d --rm --name $APP_NAME $AWS_ECR_REPOSITORY/$APP_NAME:$APP_VERSION $ALGORITHM
docker logs $APP_NAME --follow