resource "aws_ecs_cluster" "demo_aws_scheduled_job_ecs_cluster" {
  name = "${var.environment}-demo-aws-scheduled-job-ecs-cluster"
}

locals {
  aws_ecs_task_definition_container_definitions_name = "${var.environment}-demo-aws-scheduled-job"
}

data "aws_iam_policy_document" "demo_aws_scheduled_job_ecs_task_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "demo_aws_scheduled_job_ecs_task_role" {
  name               = "${var.environment}-demo-aws-scheduled-job-ecs-task-role"
  assume_role_policy = data.aws_iam_policy_document.demo_aws_scheduled_job_ecs_task_assume_role.json
}

data "aws_iam_policy_document" "demo_aws_scheduled_job_ecs_task_policy_document" {
  statement {
    effect    = "Allow"
    actions   = [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "demo_aws_scheduled_job_ecs_task_role_policy" {
  name   = "${var.environment}-demo-aws-scheduled-job-ecs-task-role-policy"
  role   = aws_iam_role.demo_aws_scheduled_job_ecs_task_role.id
  policy = data.aws_iam_policy_document.demo_aws_scheduled_job_ecs_task_policy_document.json
}

resource "aws_ecs_task_definition" "demo_aws_scheduled_job_ecs_task_definition" {
  family                   = "${var.environment}-demo-aws-scheduled-job-ecs-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048

  task_role_arn            = aws_iam_role.demo_aws_scheduled_job_ecs_task_role.arn
  execution_role_arn       = aws_iam_role.demo_aws_scheduled_job_ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name      = local.aws_ecs_task_definition_container_definitions_name
      image     = "${var.aws_account}.dkr.ecr.${var.aws_region}.amazonaws.com/demo-aws-scheduled-job:${var.job_image_version}"
      cpu       = 1024
      memory    = 1024
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
            "awslogs-group": "/aws/ecs/${var.environment}-demo-aws-scheduled-job",
            "awslogs-region": var.aws_region,
            "awslogs-stream-prefix": "ecs",
            "awslogs-create-group": "true"
        }
      }
    }
  ])
}