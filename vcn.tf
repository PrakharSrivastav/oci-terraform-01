resource "oci_core_virtual_network" "tf-vcn" {
  compartment_id = oci_identity_compartment.prakhar-tf-compartment.id
  depends_on     = [oci_identity_compartment.prakhar-tf-compartment]
  freeform_tags  = { "name" : var.common-tag-value }
  display_name   = format("%s-vcn", oci_identity_compartment.prakhar-tf-compartment.name)
  cidr_block     = "10.0.0.0/16"
  is_ipv6enabled = false
}

resource "oci_core_subnet" "tf-vcn-subnet-public" {
  cidr_block     = "10.0.0.0/24"
  depends_on     = [oci_core_virtual_network.tf-vcn]
  compartment_id = oci_identity_compartment.prakhar-tf-compartment.id
  vcn_id         = oci_core_virtual_network.tf-vcn.id
  display_name   = format("%s-subnet-public", oci_identity_compartment.prakhar-tf-compartment.name)
  freeform_tags  = { "name" : var.common-tag-value }
}

resource "oci_core_subnet" "tf-vcn-subnet-private" {
  cidr_block                = "10.0.1.0/24"
  depends_on                = [oci_core_virtual_network.tf-vcn]
  compartment_id            = oci_identity_compartment.prakhar-tf-compartment.id
  vcn_id                    = oci_core_virtual_network.tf-vcn.id
  display_name              = format("%s-subnet-private", oci_identity_compartment.prakhar-tf-compartment.name)
  freeform_tags             = { "name" : var.common-tag-value }
  prohibit_internet_ingress = true
}

