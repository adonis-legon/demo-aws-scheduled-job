resource "aws_cloudwatch_event_rule" "demo_aws_scheduled_job_sort_event_rule" {
  name                = "${var.environment}-demo-aws-scheduled-job-sort-event-rule"
  schedule_expression = var.job_schedules.sort.cron
  is_enabled          = var.job_schedules.sort.enabled
}

resource "aws_cloudwatch_event_target" "demo_aws_scheduled_job_sort_event_target" {
  target_id = "${var.environment}-demo-aws-scheduled-job-sort-event-target"
  arn       = aws_ecs_cluster.demo_aws_scheduled_job_ecs_cluster.arn
  rule      = aws_cloudwatch_event_rule.demo_aws_scheduled_job_sort_event_rule.name
  role_arn  = aws_iam_role.demo_aws_scheduled_job_cloudwatch_events_role.arn

  ecs_target {
    launch_type         = "FARGATE"
    task_count          = 1
    task_definition_arn = aws_ecs_task_definition.demo_aws_scheduled_job_ecs_task_definition.arn

    network_configuration {
      assign_public_ip = false
      security_groups = var.ecs_security_groups
      subnets = var.ecs_subnets_id
    }
  }

  input = jsonencode({
    containerOverrides = [
      {
        name = local.aws_ecs_task_definition_container_definitions_name,
        command = [
          "SORT"
        ]
      }
    ]
  })
}