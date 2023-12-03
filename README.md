# ecs-fargate-project

## overview
This project is for deploying a demo Wordpress website on AWS ECS Fargate. 

## modules
**./modules/ecs_cluster**
  * This module creates the ECS Cluster, ECS Service, & ALB.
    ```
    module "ecs_cluster" {
      source = "git@github.com:ejamilasan/ecs-fargate-project.git//modules/ecs_cluster"

      cluster_name    = var.cluster_name
      service_name    = "wordpressapp1"
      service_port    = 80
      region          = var.region
      vpc_id          = var.vpc_id
      whitelisted_ips = var.whitelisted_ips
    }
    ```

**./modules/ecs_service**
  * This module creates an ECS Service on an existing ECS Cluster with a load balancer.
    ```
    module "ecs_service" {
      source = "git@github.com:ejamilasan/ecs-fargate-project.git//modules/ecs_service"

      cluster_name    = var.cluster_name
      service_name    = "wordpressapp2"
      service_port    = 8080
      region          = var.region
      vpc_id          = var.vpc_id
      whitelisted_ips = var.whitelisted_ips
    }
    ```

## variables
  * `cluster_name`: name of the ECS cluster
  * `service_name`: name of the ECS service
  * `service_port`: the container port of the application
  * `region`: AWS region
  * `vpc_id`: AWS vpc
  * `whitelisted_ips`: IPs to be whitelisted on the ECS security group in order to access the application.

## terraform
  1. You must be authenticated to you AWS account (cli).
  2. Create `./terraform/variables.tfvars` with the following params:
      ```
      region = "us-east-1" 
      vpc_id = "vpc-12345"
      whitelisted_ips = ["x.x.x.x/x"]
      cluster_name = "wordpressdemo"
      ```
  2. Go to the `./terraform` directory then run:
      ```
      terraform init
      terraform apply -var-file=variables.tfvars
      ```