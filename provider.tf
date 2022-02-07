provider "oci" {
  tenancy_ocid     = var.root-tenant-ocid
  user_ocid        = var.tf-user-ocid
  private_key_path = var.tf-user-private-key
  fingerprint      = var.tf-user-fingerprint
  region           = var.root-tenant-region
}
