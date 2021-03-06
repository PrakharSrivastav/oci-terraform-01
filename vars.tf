variable "root-tenant-ocid" {
  default = ""
  type    = string
}

variable "tf-user-ocid" {
  default = ""
  type    = string
}

variable "tf-user-private-key" {
  default = "/Users/prakhar/.oci/sysco-pkey.pem"
  type    = string
}

variable "tf-user-fingerprint" {
  default = ""
  type    = string
}

variable "root-tenant-region" {
  default = "eu-amsterdam-1"
  type    = string
}

variable "prakhar-compartment-name" {
  default = "prakhar"
}

variable "common-tag-value" {
  default = "prakhar"
}
variable "instance-oracle-linux-0" {
  default = "Oracle Linux Instance 0"
}
variable "instance-shape-std-e4-flex" {
  default = "VM.Standard.E4.Flex"
}

variable "instance-oracle-linux-ocid" {
  default = ""
}

variable "instance-user-ssh-key" {
  default = "/Users/prakhar/sysco/oci/keys/instance-ssh-key.pub"
}