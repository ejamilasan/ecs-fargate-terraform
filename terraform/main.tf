terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      delete_later = "true"
      managed_by   = "terraform"
    }
  }
}

module "wordpress_cluster" {
  source = "git@github.com:ejamilasan/ecs-fargate-project.git//modules/ecs_cluster"

  cluster_name    = var.cluster_name
  service_name    = "wordpressapp1"
  service_port    = 80
  region          = var.region
  vpc_id          = var.vpc_id
  whitelisted_ips = var.whitelisted_ips
}

# module "wordpress_service_2" {
#   source = "git@github.com:ejamilasan/ecs-fargate-project.git//modules/ecs_service"

#   cluster_name    = var.cluster_name
#   service_name    = "wordpressapp2"
#   service_port    = 8080
#   region          = var.region
#   vpc_id          = var.vpc_id
#   whitelisted_ips = var.whitelisted_ips
# }