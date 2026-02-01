variable "region" {
  type    = string
  default = "us-east-1"
}

variable "environment" {
  type    = string
  default = "lab"
}

variable "cluster_name" {
  type    = string
  default = "test_name"
}

variable "eks_version" {
type    = string
default = "1.33"
}

variable "create_vpc" {
type    = bool
default = "false"
}


variable "vpc_id" {
  type    = string
  description = "Id vpc si ya esta creada"
  default = ""
}

variable "subnets_lists" {
  type    = list(string)
  description = "subnets agregas si ya contamos con vpc creada"
  default = ["subnet-1", "subnet-2"]
}

#
variable "vpc_name" {
  type    = string
  default = "lab"
}

variable "zone_azs" {
  type = list(string)
}

variable "vpc_cidr" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}