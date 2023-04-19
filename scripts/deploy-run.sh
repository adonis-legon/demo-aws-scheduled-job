ENVIRONMENT=${1:-dev}
. .env.$ENVIRONMENT

DEPLOY_OPTION=${2:-apply}

cd ../terraform

if [ $DEPLOY_OPTION == "plan" ]; then
  terraform plan -var-file=".env.$ENVIRONMENT.auto.tfvars"
elif [ $DEPLOY_OPTION == "apply" ]; then
  terraform apply -var-file=".env.$ENVIRONMENT.auto.tfvars" -auto-approve
elif [ $DEPLOY_OPTION == "destroy" ]; then
  terraform apply -destroy -var-file=".env.$ENVIRONMENT.auto.tfvars" -auto-approve
fi

cd ../scripts