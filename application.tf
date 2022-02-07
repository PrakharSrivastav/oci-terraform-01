#resource "oci_functions_application" "function-app" {
#  depends_on = [
#    oci_identity_compartment.tf-compartment,
#    oci_core_subnet.tf-vcn-subnet-public
#  ]
#  compartment_id = oci_identity_compartment.tf-compartment.id
#  display_name   = "function-app"
#  subnet_ids     = [
#    oci_core_subnet.tf-vcn-subnet-public.id
#  ]
#  freeform_tags = {
#    "name" : var.common-tag-value
#  }
#  network_security_group_ids = []
#}
#resource "oci_ons_notification_topic" "func-app-notification-topic" {
#  depends_on = [
#    oci_identity_compartment.tf-compartment
#  ]
#  compartment_id = oci_identity_compartment.tf-compartment.id
#  name           = "func-app-notification-topic"
#  freeform_tags  = {
#    "name" : var.common-tag-value
#  }
#  description = "Notification topic for functions app"
#}
#
#resource "oci_ons_subscription" "AS400TopicSubscription" {
#  depends_on = [
#    oci_identity_compartment.tf-compartment
#  ]
#  compartment_id = oci_identity_compartment.tf-compartment.id
#  endpoint       = "srivprakhar@gmail.com"
#  protocol       = "EMAIL"
#  topic_id       = oci_ons_notification_topic.func-app-notification-topic.id
#  freeform_tags  = {
#    "name" : var.common-tag-value
#  }
#}
#
#data "oci_objectstorage_namespace" "ns" {
#  #Optional
#  compartment_id = oci_identity_compartment.tf-compartment.id
#}
#
#resource "oci_objectstorage_bucket" "as-400-bucket" {
#  depends_on = [
#    oci_identity_compartment.tf-compartment
#  ]
#  compartment_id = oci_identity_compartment.tf-compartment.id
#  name           = "func-app-bucket"
#  namespace      = data.oci_objectstorage_namespace.ns.namespace
#  storage_tier   = "Standard"
#  versioning     = "Enabled"
#  freeform_tags  = {
#    "name" : var.common-tag-value
#  }
#  access_type           = "ObjectRead"
#  object_events_enabled = true
#}
#
#
#resource "oci_artifacts_container_repository" "prakhar-container-registry" {
#  depends_on = [
#    oci_identity_compartment.tf-compartment
#  ]
#  compartment_id = oci_identity_compartment.tf-compartment.id
#  display_name   = "prakhar-container-registry"
#  is_public      = false
#}