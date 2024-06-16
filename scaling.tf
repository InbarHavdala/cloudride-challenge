resource "aws_appautoscaling_target" "ecs_service" {
    max_capacity       = 5
    min_capacity       = 2
    resource_id        = "service/${var.ecs_cluster_name}/${aws_ecs_service.hello_world_service.name}"
    scalable_dimension = "ecs:service:DesiredCount"
    service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "autoscale_cpu" {
    name               = "container-autoscaling-policy-cpu"
    policy_type        = "TargetTrackingScaling"
    resource_id        = aws_appautoscaling_target.ecs_service.resource_id
    scalable_dimension = aws_appautoscaling_target.ecs_service.scalable_dimension
    service_namespace  = aws_appautoscaling_target.ecs_service.service_namespace

    target_tracking_scaling_policy_configuration {
        predefined_metric_specification {
            predefined_metric_type = "ECSServiceAverageCPUUtilization"
        }

        target_value = 80.0
    }
}

resource "aws_appautoscaling_policy" "autoscale_memory" {
    name               = "container-autoscaling-policy-memory"
    policy_type        = "TargetTrackingScaling"
    resource_id        = aws_appautoscaling_target.ecs_service.resource_id
    scalable_dimension = aws_appautoscaling_target.ecs_service.scalable_dimension
    service_namespace  = aws_appautoscaling_target.ecs_service.service_namespace

    target_tracking_scaling_policy_configuration {
        predefined_metric_specification {
            predefined_metric_type = "ECSServiceAverageMemoryUtilization"
        }

        target_value = 80.0
    }
}
