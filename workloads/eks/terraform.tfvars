map_roles = [
  {
    rolearn  = "arn:aws:iam::890130820425:role/EKS_AssumeRole"
    username = "EKS_AssumeRole"
    groups   = ["system:masters"]
  },
  {
    rolearn  = "arn:aws:iam::890130820425:role/Eks_Admin"
    username = "Eks_Admin"
    groups   = ["system:masters"]
  },
]

env = "sandbox"

AWS_TYPE_INSTANCE = "t3.2xlarge"
DEKS              = "1"
DMAXEKS           = "1"
DMIN              = "1"