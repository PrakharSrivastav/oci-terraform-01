resource "oci_functions_application" "AS400Replacements" {
  depends_on = [
    oci_identity_compartment.prakhar-tf-compartment,
    oci_core_subnet.tf-vcn-subnet-public
  ]
  compartment_id = oci_identity_compartment.prakhar-tf-compartment.id
  display_name   = "AS400Replacements"
  subnet_ids     = [
    oci_core_subnet.tf-vcn-subnet-public.id
  ]
  freeform_tags = {
    "name" : var.common-tag-value
  }
}
resource "oci_ons_notification_topic" "AS400NotificationTopic" {
  depends_on = [
    oci_identity_compartment.prakhar-tf-compartment
  ]
  compartment_id = oci_identity_compartment.prakhar-tf-compartment.id
  name           = "AS400NotificationTopic"
  freeform_tags  = {
    "name" : var.common-tag-value
  }
  description = "Notification topic for AS 400 replacement"
}

resource "oci_ons_subscription" "AS400TopicSubscription" {
  depends_on = [
    oci_identity_compartment.prakhar-tf-compartment
  ]
  compartment_id = oci_identity_compartment.prakhar-tf-compartment.id
  endpoint       = "srivprakhar@gmail.com"
  protocol       = "EMAIL"
  topic_id       = oci_ons_notification_topic.AS400NotificationTopic.id
  freeform_tags  = {
    "name" : var.common-tag-value
  }
}

data "oci_objectstorage_namespace" "ns" {
  #Optional
  compartment_id = oci_identity_compartment.prakhar-tf-compartment.id
}

resource "oci_objectstorage_bucket" "as-400-bucket" {
  depends_on = [
    oci_identity_compartment.prakhar-tf-compartment
  ]
  compartment_id = oci_identity_compartment.prakhar-tf-compartment.id
  name           = "as-400-bucket"
  namespace      = data.oci_objectstorage_namespace.ns.namespace
  storage_tier   = "Standard"
  versioning     = "Enabled"
  freeform_tags  = {
    "name" : var.common-tag-value
  }
  access_type           = "ObjectRead"
  object_events_enabled = true
  # retention_rules {
  #   display_name = "10 days retention rule"
  #   duration {
  #     time_amount = "10"
  #     time_unit   = "DAYS"
  #   }
  # }
}


resource "oci_artifacts_container_repository" "prakhar-tf-as400-registry" {
  depends_on = [
    oci_identity_compartment.prakhar-tf-compartment
  ]
  compartment_id = oci_identity_compartment.prakhar-tf-compartment.id
  display_name   = "as400-registry"
  is_public      = false
}