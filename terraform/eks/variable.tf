variable "cluster_name" {
  type        = string
  description = "The name of the eks cluster"

}

# eks/variable.tf
variable "subnet_ids" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "cluster_role_arn" {
  type = string
}


variable "node_name" {
  type        = string
  description = "The name of the eks cluster"

}

variable "cluster_node_arn" {
  type = string
}


variable "vpc_id" {
  type = string
}
