data "aws_iam_policy_document" "demo_aws_scheduled_job_cloudwatch_events_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "demo_aws_scheduled_job_cloudwatch_events_role" {
  name               = "${var.environment}-demo-aws-scheduled-job-event-role"
  assume_role_policy = data.aws_iam_policy_document.demo_aws_scheduled_job_cloudwatch_events_assume_role.json
}

data "aws_iam_policy_document" "demo_aws_scheduled_job_cloudwatch_events_policy_document" {
  statement {
    effect    = "Allow"
    actions   = ["iam:PassRole"]
    resources = ["*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["ecs:RunTask"]
    resources = [replace(aws_ecs_task_definition.demo_aws_scheduled_job_ecs_task_definition.arn, "/:\\d+$/", ":*")]
  }
}

resource "aws_iam_role_policy" "demo_aws_scheduled_job_cloudwatch_events_role_policy" {
  name   = "${var.environment}-demo-aws-scheduled-job-event-role-policy"
  role   = aws_iam_role.demo_aws_scheduled_job_cloudwatch_events_role.id
  policy = data.aws_iam_policy_document.demo_aws_scheduled_job_cloudwatch_events_policy_document.json
}