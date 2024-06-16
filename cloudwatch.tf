# CloudWatch Log Group for ECS Task Logs
resource "aws_cloudwatch_log_group" "ecs_task_log_group" {
  name              = "/ecs/${var.ecs_cluster_name}/task"
  retention_in_days = 7
}

#alarm for failed tasks
resource "aws_cloudwatch_metric_alarm" "ecs_task_failures" {
  alarm_name          = "ecs_task_failures"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "TaskFailed"
  namespace           = "AWS/ECS"
  period              = "300"
  statistic           = "Sum"
  threshold           = "1"
  alarm_description   = "Alarm for ECS task failures"
  dimensions = {
    ClusterName = aws_ecs_cluster.ecs_cluster.name
    ServiceName = aws_ecs_service.hello_world_service.name
  }
  alarm_actions       = [aws_sns_topic.alerts.arn]
}

resource "aws_sns_topic" "alerts" {
  name = "ecs_alerts"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = "inbar763@gmail.com"
}
