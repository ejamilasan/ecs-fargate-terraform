variable "cluster_name" {
  default = "sampleCluster"
  type    = string
}

variable "region" {
  default = "us-west-2"
  type    = string
}

variable "vpc_id" {
  default = "vpc-12345"
  type    = string
}

variable "whitelisted_ips" {
  default = ["10.0.0.0/16"]
  type    = list(any)
}