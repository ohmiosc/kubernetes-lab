region       = "us-east-1"
cluster_name = "eks-labs"
eks_version = "1.33"
environment  = "lab"
create_vpc = false
vpc_id         = "vpc-XXXXXXXXXXXXx"
subnets_lists = ["subnet-XXXXXXXXXXXXXXxx", "subnet-XXXXXXXXXXXX"]
#Variables si crearemos la vpc
vpc_name     = "vpc-lab"
vpc_cidr    = "10.0.0.0/16"
zone_azs    = ["us-east-1a", "us-east-1b"]
private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnets = ["10.0.101.0/24", "10.0.102.0/24"]