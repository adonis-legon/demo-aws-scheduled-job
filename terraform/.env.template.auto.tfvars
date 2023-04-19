environment = "environment"
aws_account = "aws_account"
aws_region = "aws_region"
aws_profile = "aws_profile"

job_image_version = "job_image_version"
job_schedules = {
    primes = {
        cron = "cron(*/10 * * * ? *)",
        enabled = true
    },
    sort = {
        cron = "cron(*/15 * * * ? *)",
        enabled = true
    }
}

ecs_vpc_id = "ecs_vpc_id"
ecs_subnets_id = "ecs_subnets_id"
ecs_security_groups = "ecs_security_groups"

tags = {
    
}