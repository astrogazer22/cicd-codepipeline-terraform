variable "cidr_block_all" {
  type    = string
  default = "0.0.0.0/0"
}

variable "cidr_block_vpc" {
  type = string
}

variable "public_subnet" {
  type = string
}

variable "availability_zone" {
  type = string
}
