resource "oci_core_vcn" "vcn_oci_free" {
  compartment_id = oci_identity_compartment.compartment.id
  cidr_block     = var.vcn_cidr_block
  display_name   = var.vcn_display_name
  dns_label      = var.vcn_dns_label
  freeform_tags  = var.tags
}

resource "oci_core_internet_gateway" "igw_oci_free" {
  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.vcn_oci_free.id
  display_name   = "igw-${var.vcn_display_name}"
  enabled        = true
  freeform_tags  = var.tags
}

resource "oci_core_route_table" "rt_public" {
  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.vcn_oci_free.id
  display_name   = "rt-public"
  freeform_tags  = var.tags

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.igw_oci_free.id
  }
}

resource "oci_core_security_list" "sl_public" {
  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.vcn_oci_free.id
  display_name   = "sl-public"
  freeform_tags  = var.tags

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      max = 443
      min = 443
    }
  }
}

resource "oci_core_subnet" "sn_oke_svc_pub" {
  compartment_id    = oci_identity_compartment.compartment.id
  vcn_id            = oci_core_vcn.vcn_oci_free.id
  cidr_block        = var.sn_oke_svc_pub_cidr
  display_name      = var.sn_oke_svc_pub_display_name
  dns_label         = var.sn_oke_svc_pub_dns_label
  route_table_id    = oci_core_route_table.rt_public.id
  security_list_ids = [oci_core_security_list.sl_public.id]
  freeform_tags     = var.tags
}

resource "oci_core_nat_gateway" "ngw_oci_free" {
  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.vcn_oci_free.id
  display_name   = "nat-${var.vcn_display_name}"
  freeform_tags  = var.tags
}

resource "oci_core_route_table" "rt_private" {
  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.vcn_oci_free.id
  display_name   = "rt-private"
  freeform_tags  = var.tags

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.ngw_oci_free.id
  }
}

resource "oci_core_security_list" "sl_private" {
  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.vcn_oci_free.id
  display_name   = "sl-private"
  freeform_tags  = var.tags

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }

  ingress_security_rules {
    protocol = "all"
    source   = "0.0.0.0/0"
  }
}

resource "oci_core_subnet" "sn_oke_api_priv" {
  compartment_id    = oci_identity_compartment.compartment.id
  vcn_id            = oci_core_vcn.vcn_oci_free.id
  cidr_block        = var.sn_oke_api_priv_cidr
  display_name      = var.sn_oke_api_priv_display_name
  dns_label         = var.sn_oke_api_priv_dns_label
  route_table_id    = oci_core_route_table.rt_private.id
  security_list_ids = [oci_core_security_list.sl_private.id]
  freeform_tags     = var.tags
}

resource "oci_core_subnet" "sn_oke_nodes_priv" {
  compartment_id    = oci_identity_compartment.compartment.id
  vcn_id            = oci_core_vcn.vcn_oci_free.id
  cidr_block        = var.sn_oke_nodes_priv_cidr
  display_name      = var.sn_oke_nodes_priv_display_name
  dns_label         = var.sn_oke_nodes_priv_dns_label
  route_table_id    = oci_core_route_table.rt_private.id
  security_list_ids = [oci_core_security_list.sl_private.id]
  freeform_tags     = var.tags
}
