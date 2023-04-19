ENVIRONMENT=${1:-dev}
. .env.$ENVIRONMENT

TF_BACKEND_BUCKET_KEY=terraform.tfstate

cd ../terraform

terraform init \
-backend-config="bucket=$TF_BACKEND_BUCKET_NAME" \
-backend-config="key=$TF_BACKEND_BUCKET_KEY"

cd ../scripts