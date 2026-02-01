module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  create_kms_key = false
  cluster_encryption_config = {}

  cluster_name    = "${var.cluster_name}-${var.environment}"
  cluster_version = var.eks_version

  vpc_id     = var.create_vpc == true ? module.vpc[0].vpc_id : var.vpc_id
  subnet_ids = var.create_vpc == true ? module.vpc[0].private_subnets : var.subnets_lists

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  enable_irsa = true

  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.medium"]
      desired_size   = 1
      min_size       = 1
      max_size       = 3
    }
  }

  access_entries = {
    eks_admin_user = {
      principal_arn = aws_iam_role.eks_admin_role.arn # "arn:aws:iam::123456789012:user/eks-admin-user"

      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }
}