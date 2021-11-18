data aws_vpc vpc {
  filter {
    name   = "tag:Name"
    values = ["gs-vpc"]
  }
}

data aws_subnet_ids private {
  vpc_id = data.aws_vpc.vpc.id
  filter {
    name   = "tag:Name"
    values = ["gs-vpc-app*"]
  }
}
output vpcs {
    value = [
        data.aws_vpc.vpc.id,
        data.aws_subnet_ids.private
    ]
}


data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.11"
}

module "eks" {
  source                               = "../../modules/eks/"
  cluster_name                         = "gs-vpc"
  subnets                              = data.aws_subnet_ids.private.ids
  vpc_id                               = data.aws_vpc.vpc.id
  map_roles                            = var.map_roles
  manage_aws_auth                      = true
  #worker_additional_security_group_ids = [module.SG.sgoutput]
  cluster_enabled_log_types            = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  cluster_version                      = "1.19"
  cluster_endpoint_private_access = false
  cluster_endpoint_public_access = true
  worker_groups = [
    {
      instance_type                 = "%{if var.env == "prod" || var.env == "stress-test"}${var.AWS_TYPE_INSTANCE}%{else}t3.2xlarge%{endif}"
      asg_max_size                  = "%{if var.env == "prod" || var.env == "stress-test"}${var.DMAXEKS}%{else}1%{endif}"
      asg_desired_capacity          = "%{if var.env == "prod" || var.env == "stress-test"}${var.DMIN}%{else}1%{endif}"
      key_name                      = "eks-lab-cloudit"

    },
    {
      instance_type                 = "%{if var.env == "prod" || var.env == "stress-test"}${var.AWS_TYPE_INSTANCE}%{else}t3.2xlarge%{endif}"
      asg_max_size                  = "%{if var.env == "prod" || var.env == "stress-test"}${var.DMAXEKS}%{else}2%{endif}"
      asg_desired_capacity          = "%{if var.env == "prod" || var.env == "stress-test"}${var.DMIN}%{else}2%{endif}"
      key_name  = "eks-lab-cloudit"

    }
  ]
  tags = {
    Name                                                   = "shared"
    Terraform                                              = true
    APP                                                    = "gs-vpc"
    Projeto                                                = "gs-vpc"
    Requerente                                             = "gs-vpc"
    Ambiente                                               = "sandbox"
    "kubernetes.io/cluster/shared" = "shared"

  }
}

module "start-stop-node-dmz" {
  source                      = "../../modules/start-stop-node/"
  env                         = "sandbox"
  scheduled_action_name_start = "start"
  scheduled_action_name_stop  = "stop"
  recurrence_start            = "0 06 * * *"
  recurrence_stop             = "0 00 * * *"
  autoscaling_group_name      = module.eks.NAME-AUTOSCALING[0]
}

module "start-stop-node-app" {
  source                      = "../../modules/start-stop-node/"
  env                         = "sandbox"
  scheduled_action_name_start = "start-app"
  scheduled_action_name_stop  = "stop-app"
  recurrence_start            = "0 06 * * *"
  recurrence_stop             = "0 00 * * *"
  autoscaling_group_name      = module.eks.NAME-AUTOSCALING[1]
}


