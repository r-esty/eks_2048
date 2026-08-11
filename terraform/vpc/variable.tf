variable "cidr_block" {
  type = string
  description = "This is the cidr block for the vpc "
}

variable "public_1_cidr_block" {
    type = string
    description = "This is the cidr block for the public subnet 1"
  
}

variable "public_2_cidr_block" {
    type = string
    description = "This is the cidr block for the public subnet 2"
  
}

variable "availability_zone_1" {
  type = string
  description = "This is the availability zone for the public subnet 1"
}

variable "availability_zone_2" {
  type = string
  description = "This is the availability zone for the public subnet 2"
}

variable "private_1_cidr_block" {
    type = string
    description = "This is the cidr block for the private subnet 1"
  
}

variable "private_2_cidr_block" {
    type = string
    description = "This is the cidr block for the private subnet 2"
  
}



