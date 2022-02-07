# Output the "list" of all availability domains.
output "all-availability-domains-in-your-tenancy" {
  value = data.oci_identity_availability_domains.ads.availability_domains
}

# Outputs for compartment
output "compartment-name" {
  value = oci_identity_compartment.tf-compartment.name
}
output "compartment-OCID" {
  value = oci_identity_compartment.tf-compartment.id
}

#output "public-ip-for-compute-instance" {
#  value = oci_core_instance.tf-oracle-inst-0.public_ip
#}
#
#output "instance-name" {
#  value = oci_core_instance.tf-oracle-inst-0.display_name
#}
#
#output "instance-OCID" {
#  value = oci_core_instance.tf-oracle-inst-0.id
#}
#
#output "instance-region" {
#  value = oci_core_instance.tf-oracle-inst-0.region
#}
#
#output "instance-shape" {
#  value = oci_core_instance.tf-oracle-inst-0.shape
#}
#
#output "instance-state" {
#  value = oci_core_instance.tf-oracle-inst-0.state
#}
#
#output "instance-OCPUs" {
#  value = oci_core_instance.tf-oracle-inst-0.shape_config[0].ocpus
#}
#
#output "instance-memory-in-GBs" {
#  value = oci_core_instance.tf-oracle-inst-0.shape_config[0].memory_in_gbs
#}
#
#output "time-created" {
#  value = oci_core_instance.tf-oracle-inst-0.time_created
#}

#output "as400-application-name" {
#  value = oci_functions_application.function-app.display_name
#}
#
#output "as400-application-id" {
#  value = oci_functions_application.function-app.id
#}
