# Cloudride Challenge: AWS Infrastructure and CI/CD Pipeline Deployment

This repository contains Terraform scripts and GitHub Actions workflows to deploy and manage AWS infrastructure and automate CI/CD pipelines for a simple "Hello World" application on ECS.

## Table of Contents

1. [Overview](#overview)
2. [Infrastructure Deployment](#infrastructure-deployment)
3. [CI/CD Pipeline](#ci-cd-pipeline)
4. [AWS Pillars](#aws-pillars)

---

## Overview

The Cloudride challenge involves setting up and automating AWS infrastructure and CI/CD processes using Terraform and GitHub Actions. This README provides a detailed overview of the deployed infrastructure and the automation pipeline.

---

## Infrastructure Deployment

### VPC Architecture

The infrastructure includes:

- **VPC**: Created with public and private subnets across multiple availability zones (AZs).
- **Internet Gateway**: Attached to the VPC for internet access from public subnets.
- **Subnets**: Two public subnets and two private subnets distributed across different AZs for high availability.
- **Route Tables**: Configured to route traffic between subnets and to the internet via the internet gateway.
- **Security Groups**: Defined to control inbound and outbound traffic for ECS containers and other resources.

### ECS Cluster and Services

- **ECS Cluster**: Created to host Docker containers.
- **Task Definition**: Specifies the configuration for the "Hello World" Docker container, including resource allocation and network settings.
- **Service**: ECS Service configured with Service Auto Scaling to maintain a desired count of at least 2 tasks (containers) based on metrics like CPU utilization.
- **Load Balancer**: Application Load Balancer (ALB) deployed in public subnets to manage incoming traffic to ECS services.
- **Monitoring**: CloudWatch Alarms set up to monitor ECS task health, triggering alerts for container errors or other issues.

---

## CI/CD Pipeline

### GitHub Actions Workflow

- **Continuous Integration**: On push to the main branch, GitHub Actions triggers a workflow that:
  - Checks out the source code.
  - Configures AWS credentials and logs into Amazon ECR.
  - Builds the Docker image, tags it with a unique identifier.
  - Pushes the image to the specified ECR repository.
  - Updates the ECS task definition with the new image URI.
- **Continuous Deployment**: The updated task definition triggers a deployment to ECS, ensuring the latest changes are applied to the running containers.

---

## AWS Pillars

The solution adheres to AWS pillars of:

- **Operational Excellence**: Automation of infrastructure deployment and CI/CD pipelines improves operational efficiency and reduces manual intervention.
- **Security**: Implementation of VPC, subnet segregation, and security groups ensures network isolation and controlled access to resources.
- **Reliability**: High availability architecture with multiple AZs, ECS Service Auto Scaling, and monitoring helps ensure reliable application performance.
- **Performance Efficiency**: Efficient resource allocation using Fargate, autoscaling based on CPU metrics, and ALB routing contribute to optimized performance.
- **Cost Optimization**: Use of managed services like ECS, ALB, and Fargate optimizes operational costs while scaling resources based on demand.

---
