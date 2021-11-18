# module-aws-eks-openfinance



## Getting started

##Version terraofrm Terraform v1.0.0
```terraform


data aws_vpc vpc {
  filter {
    name   = "tag:Name"
    values = ["NAME-YOUR-VPC"]
  }

}

data aws_subnet_ids private {
  vpc_id = data.aws_vpc.vpc.id
  filter {
    name   = "tag:Name"
    values = ["main_YOUR_SUBNETS_*"]
  }
}
output vpcs {
    value = [
        data.aws_vpc.vpc.id,
        data.aws_subnet_ids.private
    ]
}

module "SG" {
  source             = "git::REPOSG"
  name_prefix        = var.name_prefix
  env                = var.env
  app                = "NomeApp"
  modalidade         = "EksCluster"
  projeto            = "NomeProjeto"
  cluster-name       = var.cluster-name
  vpc_id             = data.aws_vpc.vpc.id
  services_ports     = ["22","80","3389"]
  protocol           = "tcp"
  list_ips = [data.aws_vpc.vpc.cidr_block,"0.0.0.0/0"]
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
  source                               = "git::ReposEks"
  cluster_name                         = "${var.cluster-name}-${var.env}"
  subnets                              = data.aws_subnet_ids.private.ids
  vpc_id                               = data.aws_vpc.vpc.id
  map_roles                            = var.map_roles
  manage_aws_auth                      = true
  worker_additional_security_group_ids = [module.SG.sgoutput]
  cluster_enabled_log_types            = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  cluster_version                      = var.versionCluster
  cluster_endpoint_private_access = false
  cluster_endpoint_public_access = true
  worker_groups = [
    {
      instance_type                 = "%{if var.env == "prod" || var.env == "stress-test"}${var.AWS_TYPE_INSTANCE}%{else}t3a.large%{endif}"
      asg_max_size                  = "%{if var.env == "prod" || var.env == "stress-test"}${var.DMAXEKS}%{else}2%{endif}"
      asg_desired_capacity          = "%{if var.env == "prod" || var.env == "stress-test"}${var.DMIN}%{else}2%{endif}"
      kubelet_extra_args            = "--node-labels=bcbtg=microservices"
      additional_security_group_ids = [module.SG.sgoutput]
      key_name                      = var.keyName

    },
    {
      instance_type                 = "%{if var.env == "prod" || var.env == "stress-test"}${var.AWS_TYPE_INSTANCE}%{else}t3a.xlarge%{endif}"
      asg_max_size                  = "%{if var.env == "prod" || var.env == "stress-test"}${var.DMAXEKS}%{else}2%{endif}"
      asg_desired_capacity          = "%{if var.env == "prod" || var.env == "stress-test"}${var.DMIN}%{else}2%{endif}"
      kubelet_extra_args            = "--node-labels=bcpan=microservices"
      additional_security_group_ids = [module.SG.sgoutput]
      key_name                      = var.keyName
    }
  ]
  tags = {
    Name                                                   = "${var.cluster-name}-${var.env}"
    Terraform                                              = true
    APP                                                    = "NameApp"
    Projeto                                                = "NameProjeto"
    Requerente                                             = var.requerente
    Ambiente                                               = var.env
    "kubernetes.io/cluster/${var.cluster-name}-${var.env}" = "${var.cluster-name}-${var.env}"

  }
}

module "SCHEDULE-NODE-BCBTG" {
  source                      = "/Users/raphael/Documents/projetos-fcTeam/engine-schedule-start-stop-aws"
  env                         = var.env
  scheduled_action_name_start = var.scheduled_action_name_start
  scheduled_action_name_stop  = var.scheduled_action_name_stop
  recurrence_start            = var.recurrence_start
  recurrence_stop             = var.recurrence_stop
  autoscaling_group_name      = module.eks.NAME-AUTOSCALING[0] #Zero pois estamos utlizando dois workers nodes, sendo esse o primeiro
}

module "SCHEDULE-NODE-BCPAN" {
  source                      = "/Users/raphael/Documents/projetos-fcTeam/engine-schedule-start-stop-aws"
  env                         = var.env
  scheduled_action_name_start = var.scheduled_action_name_start
  scheduled_action_name_stop  = var.scheduled_action_name_stop
  recurrence_start            = var.recurrence_start
  recurrence_stop             = var.recurrence_stop
  autoscaling_group_name      = module.eks.NAME-AUTOSCALING[1]
}
```
## Add your files

- [ ] [Create](https://gitlab.com/-/experiment/new_project_readme_content:b782a49739fb7f4f61b2d9b7a25f0b9e?https://docs.gitlab.com/ee/user/project/repository/web_editor.html#create-a-file) or [upload](https://gitlab.com/-/experiment/new_project_readme_content:b782a49739fb7f4f61b2d9b7a25f0b9e?https://docs.gitlab.com/ee/user/project/repository/web_editor.html#upload-a-file) files
- [ ] [Add files using the command line](https://gitlab.com/-/experiment/new_project_readme_content:b782a49739fb7f4f61b2d9b7a25f0b9e?https://docs.gitlab.com/ee/gitlab-basics/add-file.html#add-a-file-using-the-command-line) or push an existing Git repository with the following command:

```
cd existing_repo
git remote add origin https://gitlab.com/omnifinance/openfinance-fcamara-iac-modules/module-aws-eks-openfinance.git
git branch -M main
git push -uf origin main
```

## Integrate with your tools

- [ ] [Set up project integrations](https://gitlab.com/-/experiment/new_project_readme_content:b782a49739fb7f4f61b2d9b7a25f0b9e?https://docs.gitlab.com/ee/user/project/integrations/)

## Collaborate with your team

- [ ] [Invite team members and collaborators](https://gitlab.com/-/experiment/new_project_readme_content:b782a49739fb7f4f61b2d9b7a25f0b9e?https://docs.gitlab.com/ee/user/project/members/)
- [ ] [Create a new merge request](https://gitlab.com/-/experiment/new_project_readme_content:b782a49739fb7f4f61b2d9b7a25f0b9e?https://docs.gitlab.com/ee/user/project/merge_requests/creating_merge_requests.html)
- [ ] [Automatically close issues from merge requests](https://gitlab.com/-/experiment/new_project_readme_content:b782a49739fb7f4f61b2d9b7a25f0b9e?https://docs.gitlab.com/ee/user/project/issues/managing_issues.html#closing-issues-automatically)
- [ ] [Automatically merge when pipeline succeeds](https://gitlab.com/-/experiment/new_project_readme_content:b782a49739fb7f4f61b2d9b7a25f0b9e?https://docs.gitlab.com/ee/user/project/merge_requests/merge_when_pipeline_succeeds.html)

## Test and Deploy

Use the built-in continuous integration in GitLab.

- [ ] [Get started with GitLab CI/CD](https://gitlab.com/-/experiment/new_project_readme_content:b782a49739fb7f4f61b2d9b7a25f0b9e?https://docs.gitlab.com/ee/ci/quick_start/index.html)
- [ ] [Analyze your code for known vulnerabilities with Static Application Security Testing(SAST)](https://gitlab.com/-/experiment/new_project_readme_content:b782a49739fb7f4f61b2d9b7a25f0b9e?https://docs.gitlab.com/ee/user/application_security/sast/)
- [ ] [Deploy to Kubernetes, Amazon EC2, or Amazon ECS using Auto Deploy](https://gitlab.com/-/experiment/new_project_readme_content:b782a49739fb7f4f61b2d9b7a25f0b9e?https://docs.gitlab.com/ee/topics/autodevops/requirements.html)
- [ ] [Use pull-based deployments for improved Kubernetes management](https://gitlab.com/-/experiment/new_project_readme_content:b782a49739fb7f4f61b2d9b7a25f0b9e?https://docs.gitlab.com/ee/user/clusters/agent/)

***

# Editing this README

When you're ready to make this README your own, just edit this file and use the handy template below (or feel free to structure it however you want - this is just a starting point!).  Thank you to [makeareadme.com](https://gitlab.com/-/experiment/new_project_readme_content:b782a49739fb7f4f61b2d9b7a25f0b9e?https://www.makeareadme.com/) for this template.

## Suggestions for a good README
Every project is different, so consider which of these sections apply to yours. The sections used in the template are suggestions for most open source projects. Also keep in mind that while a README can be too long and detailed, too long is better than too short. If you think your README is too long, consider utilizing another form of documentation rather than cutting out information.

## Name
Choose a self-explaining name for your project.

## Description
Let people know what your project can do specifically. Provide context and add a link to any reference visitors might be unfamiliar with. A list of Features or a Background subsection can also be added here. If there are alternatives to your project, this is a good place to list differentiating factors.

## Badges
On some READMEs, you may see small images that convey metadata, such as whether or not all the tests are passing for the project. You can use Shields to add some to your README. Many services also have instructions for adding a badge.

## Visuals
Depending on what you are making, it can be a good idea to include screenshots or even a video (you'll frequently see GIFs rather than actual videos). Tools like ttygif can help, but check out Asciinema for a more sophisticated method.

## Installation
Within a particular ecosystem, there may be a common way of installing things, such as using Yarn, NuGet, or Homebrew. However, consider the possibility that whoever is reading your README is a novice and would like more guidance. Listing specific steps helps remove ambiguity and gets people to using your project as quickly as possible. If it only runs in a specific context like a particular programming language version or operating system or has dependencies that have to be installed manually, also add a Requirements subsection.

## Usage
Use examples liberally, and show the expected output if you can. It's helpful to have inline the smallest example of usage that you can demonstrate, while providing links to more sophisticated examples if they are too long to reasonably include in the README.

## Support
Tell people where they can go to for help. It can be any combination of an issue tracker, a chat room, an email address, etc.

## Roadmap
If you have ideas for releases in the future, it is a good idea to list them in the README.

## Contributing
State if you are open to contributions and what your requirements are for accepting them.

For people who want to make changes to your project, it's helpful to have some documentation on how to get started. Perhaps there is a script that they should run or some environment variables that they need to set. Make these steps explicit. These instructions could also be useful to your future self.

You can also document commands to lint the code or run tests. These steps help to ensure high code quality and reduce the likelihood that the changes inadvertently break something. Having instructions for running tests is especially helpful if it requires external setup, such as starting a Selenium server for testing in a browser.

## Authors and acknowledgment
Show your appreciation to those who have contributed to the project.

## License
For open source projects, say how it is licensed.

## Project status
If you have run out of energy or time for your project, put a note at the top of the README saying that development has slowed down or stopped completely. Someone may choose to fork your project or volunteer to step in as a maintainer or owner, allowing your project to keep going. You can also make an explicit request for maintainers.

