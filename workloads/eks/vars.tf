variable "map_roles" {
  description = "AdditionalIAMrolestoaddtotheaws-authconfigmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
}

variable env { type = string }



variable "AWS_TYPE_INSTANCE" {
  type        = string
  description = "tipo da instancia"
}

variable "DEKS" {
  type = string
}

variable "DMAXEKS" {
  type = string
}

variable "DMIN" {
  type = string
}