resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs_task_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ]
}

resource "aws_iam_role" "autoscaling_role" {
  name               = "terraform-autoscaling-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "autoscaling_policy" {
  name        = "terraform-autoscaling-policy"
  description = "Allows managing Application Auto Scaling resources"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = [
          "application-autoscaling:RegisterScalableTarget",
          "application-autoscaling:PutScalingPolicy"
        ]
        Resource  = "*"
      },
      {
        Effect    = "Allow"
        Action    = "ecs:UpdateService"
        Resource  = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_autoscaling_policy" {
  role       = aws_iam_role.autoscaling_role.name
  policy_arn = aws_iam_policy.autoscaling_policy.arn
}
