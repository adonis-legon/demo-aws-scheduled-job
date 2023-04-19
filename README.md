# Demo project for running a Python script as an AWS Batch Job with multiple schedulers

## Setup local Development environment

1. Create a *.env.{env-name}* file using the template *.env.template* as a reference, and put it on the scripts folder (This is done just one time)
2. Fill the environment file with all variables specified

## Build and Push Image

1. Create a private/public repository on AWS ECR in your prefered AWS Account and Region, with the name: **demo-aws-scheduled-job**
2. Run Build and Push Image script

```console
scripts$ # command format
scripts$ # . build.sh <env-name>
scripts$ # example
scripts$ . build.sh dev
```

## Run Container Locally

1. Run with a specific algorithm for the app, with the available options of:
- PRIMES
- SORT

```console
scripts$ # command format
scripts$ # . local-run.sh <env-name> <algorithm-type>
scripts$ # example
scripts$ . local-run.sh dev PRIMES
```

## Setup local Terraform environment

1. Create an S3 bucket to store Terraform's state (this is done just one time)

```console
terraform$ . deploy-init.sh
```

## Deploy

1. Create a *.env.{env-name}.auto.tfvars* file using the template *.env.template.auto.tfvars* as a reference, and put it on the terraform folder
2. Run the deploy script with different options

```console
scripts$ # command format
scripts$ # . deploy-run.sh <env-name> <deploy-option>
```

### Review Infrastructure changes

```console
scripts$ . deploy-run.sh dev plan
```

### Update Infrastructure

```console
scripts$ . deploy-run.sh dev apply
```

### Delete Infrastructure

```console
scripts$ . deploy-run.sh dev destroy
```