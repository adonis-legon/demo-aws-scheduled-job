variable "environment" {
  type = string
  description = "Environment identifier for the application infrastructure"
}

variable "aws_account" {
  type = string
  description = "AWS Account for the application infrastructure"
}

variable "aws_region" {
  type = string
  description = "AWS Region for the application infrastructure"
}

variable "aws_profile" {
  type = string
  description = "AWS Profile on the path $HOME/.aws/config and $HOME/.aws/credentials"
}

variable "job_image_version" {
  type = string
  description = "Image version (tag) of the Batch application"
}

variable "job_schedules" {
  type = object({
    primes = object({
      cron = string
      enabled = bool
    })
    sort = object({
      cron = string
      enabled = bool
    })
  })
  description = "Job schedule configuration per job type (e.g. primes algorithm, sort algorithm, etc)"
}

variable "ecs_vpc_id" {
    type = string
    description = "AWS VPC where all resources are deployed"
}

variable "ecs_subnets_id" {
    type = list(string)
    description = "VPC Subnets where the ECS Fargate cluster will asign IPs to instances"
}

variable "ecs_security_groups" {
    type = list(string)
    description = "Security Groups for the ECS Fargate tasks"
}

variable "tags" {
  type = map(string)
  description = "Common tags for all resources."
}