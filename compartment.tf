resource "oci_identity_compartment" "prakhar-tf-compartment" {
  # Required
  compartment_id = var.root-tenant-ocid
  description    = "Compartment created using terraform"
  name           = var.prakhar-compartment-name
  freeform_tags  = {
    "name" : var.common-tag-value
  }
}