resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "hello_world" {
  family                   = "hello_world"
  
  container_definitions    = <<DEFINITION
  [
    {
      "name": "${var.app_name}",
      "image": "${aws_ecr_repository.hello_world_repo.repository_url}",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80
        }
      ],
      "memory": 512,
      "cpu": 256
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"] 
  network_mode             = "awsvpc"    
  memory                   = 512         
  cpu                      = 256       
  execution_role_arn       = "${aws_iam_role.ecs_task_execution_role.arn}"
}

resource "aws_ecs_service" "hello_world_service" {
  name            = "hello_world_service"                            
  cluster         = "${aws_ecs_cluster.ecs_cluster.id}"       
  task_definition = "${aws_ecs_task_definition.hello_world.arn}" 
  launch_type     = "FARGATE"
  desired_count   = 2 # at least 2 containers
  
  load_balancer {
    target_group_arn = aws_lb_target_group.hello_world_tg.arn
    container_name   = "hello_world"
    container_port   = 80
  }

  network_configuration {
    subnets          = module.vpc.private_subnets
    security_groups  = ["${aws_security_group.ecs_service.id}"] # the sg of the service
  }
}
