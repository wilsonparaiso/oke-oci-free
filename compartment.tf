resource "oci_identity_compartment" "compartment" {
  compartment_id = var.tenancy_ocid
  name           = var.compartment_name
  description    = var.compartment_description
  freeform_tags  = var.tags
}
