variable "cluster_name" { 
  type = string
}

variable "service_name" { 
  type = string
}

variable "service_port" { 
  type = number
}

variable "region" {
  type = string
}

variable "vpc_id" { 
  type = string
}

variable "whitelisted_ips" {
  type = list
}