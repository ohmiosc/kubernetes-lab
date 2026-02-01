variable "region" {
  type    = string
  default = "us-east-1"
}
variable "cluster_name" {
  type    = string
  default = "test_name"
}
variable "vpc_name" {
  type    = string
  default = "lab"
}
variable "environment" {
  type    = string
  default = "lab"
}
variable "subnets_lists" {
  type    = list(string)
  default = ["subnet-1", "subnet-2"]
}
variable "eks_version" {
type    = string
default = "1.33"
}
variable "create_vpc" {
type    = bool
default = "false"
}