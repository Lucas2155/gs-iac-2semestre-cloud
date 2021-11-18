map_roles = [
  {
    rolearn  = "arn:aws:iam::786623674405:role/eks-admin-assume-role"
    username = "eks-admin-assume-role"
    groups   = ["system:masters"]
  },
  {
    rolearn  = "arn:aws:iam::786623674405:role/eks-admin-group"
    username = "eks-admin-group"
    groups   = ["system:masters"]
  },
]

env = "sandbox"

AWS_TYPE_INSTANCE = "t3.2xlarge"
DEKS              = "1"
DMAXEKS           = "1"
DMIN              = "1"