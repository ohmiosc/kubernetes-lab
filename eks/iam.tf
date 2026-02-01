########################################
# IAM ROLE - EKS ADMIN
########################################
resource "aws_iam_role" "eks_admin_role" {
  name = "eks-admin-role-${var.cluster_name}-${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

########################################
# IAM POLICY - ALLOW ASSUME ROLE
########################################
resource "aws_iam_policy" "allow_assume_eks_admin_role" {
  name        = "AllowAssumeEKSAdminRole-${var.cluster_name}-${var.environment}"
  description = "Permite asumir el rol de administrador de EKS/Kubernetes"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "sts:AssumeRole"
        Resource = aws_iam_role.eks_admin_role.arn
      }
    ]
  })
}

########################################
# IAM GROUP + USERS
########################################
module "eks_admins_iam_group" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  version = "5.3.1"

  name         = "eks-admins-${var.cluster_name}-${var.environment}"
  create_group = true

  group_users = [
    "HectorCuadros",
  ]

  custom_group_policy_arns = [
    aws_iam_policy.allow_assume_eks_admin_role.arn
  ]
}
