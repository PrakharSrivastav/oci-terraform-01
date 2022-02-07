resource "oci_core_vcn" "tf-vcn" {
  compartment_id = oci_identity_compartment.tf-compartment.id
  depends_on     = [oci_identity_compartment.tf-compartment]
  freeform_tags  = { "name" : var.common-tag-value }
  display_name   = format("%s-vcn", oci_identity_compartment.tf-compartment.name)
  cidr_block     = "10.0.0.0/16"
  is_ipv6enabled = false
  dns_label      = var.common-tag-value
}

resource "oci_core_internet_gateway" "tf-vcn-ig" {
  depends_on     = [oci_core_vcn.tf-vcn]
  compartment_id = oci_identity_compartment.tf-compartment.id
  vcn_id         = oci_core_vcn.tf-vcn.id
  display_name   = format("%s-internet-gateway", oci_identity_compartment.tf-compartment.name)
  enabled        = true
  freeform_tags  = { "name" : var.common-tag-value }
}

resource "oci_core_default_route_table" "tf-vcn-default-rt" {
  manage_default_resource_id = oci_core_vcn.tf-vcn.default_route_table_id
  compartment_id             = oci_identity_compartment.tf-compartment.id
  depends_on                 = [
    oci_identity_compartment.tf-compartment,
    oci_core_vcn.tf-vcn,
    oci_core_internet_gateway.tf-vcn-ig
  ]
  freeform_tags = { "name" : var.common-tag-value }
  display_name  = format("default route table for %s", oci_core_vcn.tf-vcn.display_name )
  route_rules {
    network_entity_id = oci_core_internet_gateway.tf-vcn-ig.id
    description       = "Internet Gateway"
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
  }
}

resource "oci_core_default_security_list" "tf-vcn-default-sl" {
  manage_default_resource_id = oci_core_vcn.tf-vcn.default_security_list_id
  compartment_id             = oci_identity_compartment.tf-compartment.id
  freeform_tags              = { "name" : var.common-tag-value }
  display_name               = "default security list"
  depends_on                 = [oci_identity_compartment.tf-compartment]
  ingress_security_rules {
    protocol  = "6"
    source    = "0.0.0.0/0"
    stateless = false
    tcp_options {
      min = 22
      max = 22
    }
  }
  ingress_security_rules {
    protocol  = "1"
    source    = "0.0.0.0/0"
    stateless = false
    icmp_options {
      type = 3
      code = 4
    }
  }
  ingress_security_rules {
    protocol  = "1"
    source    = "10.0.0.0/16"
    stateless = false
    icmp_options {
      type = 3
    }
  }
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
    stateless   = false
  }
}


resource "oci_core_default_dhcp_options" "tf-vcn-default-dhcp" {
  manage_default_resource_id = oci_core_vcn.tf-vcn.default_dhcp_options_id
  depends_on                 = [oci_core_vcn.tf-vcn]
  freeform_tags              = { "name" : var.common-tag-value }
  display_name               = format("default dhcp options for %s", oci_core_vcn.tf-vcn.display_name)
  compartment_id             = oci_identity_compartment.tf-compartment.id
  options {
    search_domain_names = ["prakhar.oraclevcn.com"]
    type                = "SearchDomain"
  }
  options {
    type        = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }
}


resource "oci_core_security_list" "tf-vcn-subnet-public-sl" {
  vcn_id         = oci_core_vcn.tf-vcn.id
  compartment_id = oci_identity_compartment.tf-compartment.id
  freeform_tags  = { "name" : var.common-tag-value }
  display_name   = "public security list"
  depends_on     = [
    oci_identity_compartment.tf-compartment,
    oci_core_vcn.tf-vcn
  ]

  ingress_security_rules {
    protocol  = "6"
    source    = "0.0.0.0/0"
    stateless = false
    tcp_options {
      min = 22
      max = 22
    }
  }
  ingress_security_rules {
    protocol  = "1"
    source    = "0.0.0.0/0"
    stateless = false
    icmp_options {
      type = 3
      code = 4
    }
  }
  ingress_security_rules {
    protocol  = "1"
    source    = "10.0.0.0/16"
    stateless = false
    icmp_options {
      type = 3
    }
  }
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
    stateless   = false
  }
}

resource "oci_core_subnet" "tf-vcn-subnet-public" {
  cidr_block        = "10.0.0.0/24"
  depends_on        = [oci_core_vcn.tf-vcn]
  compartment_id    = oci_identity_compartment.tf-compartment.id
  vcn_id            = oci_core_vcn.tf-vcn.id
  display_name      = format("%s-subnet-public", oci_identity_compartment.tf-compartment.name)
  freeform_tags     = { "name" : var.common-tag-value }
  security_list_ids = [oci_core_security_list.tf-vcn-subnet-public-sl.id]
}

resource "oci_core_route_table" "tf-vcn-subnet-public-rt" {
  compartment_id = oci_identity_compartment.tf-compartment.id
  vcn_id         = oci_core_vcn.tf-vcn.id
  depends_on     = [oci_core_vcn.tf-vcn]
  freeform_tags  = { "name" : var.common-tag-value }
  display_name   = format("%s-subnet-public-rt", oci_identity_compartment.tf-compartment.name)
  route_rules {
    network_entity_id = oci_core_internet_gateway.tf-vcn-ig.id
    description       = "Internet Gateway"
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
  }
}

resource "oci_core_subnet" "tf-vcn-subnet-private" {
  cidr_block                = "10.0.1.0/24"
  depends_on                = [oci_core_vcn.tf-vcn]
  compartment_id            = oci_identity_compartment.tf-compartment.id
  vcn_id                    = oci_core_vcn.tf-vcn.id
  display_name              = format("%s-subnet-private", oci_identity_compartment.tf-compartment.name)
  freeform_tags             = { "name" : var.common-tag-value }
  prohibit_internet_ingress = true
}


# internet gateway
# routing table add IG
# Default Security List for tf-compartment-vcn
# - ingress rule
#   - TCP traffic for ports: 22 SSH Remote Login Protocol
#   - ICMP traffic for: 3, 4 Destination Unreachable: Fragmentation Needed and Don't Fragment was Set
#   - ICMP traffic for: 3 Destination Unreachable
#   - TCP traffic for ports: All
# - EGRESS rule
#   - All AMS Services In Oracle Services Network, All protocols (all-ams-services-in-oracle-services-network)
#   - All traffic for all ports
#   - TCP traffic for ports: All

# Create DHCP Options
# Internet and VCN Resolver
