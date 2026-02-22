resource "oci_containerengine_cluster" "oke_cluster" {
  compartment_id     = oci_identity_compartment.compartment.id
  kubernetes_version = var.oke_kubernetes_version
  name               = var.oke_cluster_name
  vcn_id             = oci_core_vcn.vcn_oci_free.id
  type               = "BASIC_CLUSTER"

  endpoint_config {
    is_public_ip_enabled = false
    subnet_id            = oci_core_subnet.sn_oke_api_priv.id
  }

  options {
    service_lb_subnet_ids = [oci_core_subnet.sn_oke_svc_pub.id]
  }

  freeform_tags = var.tags
}

resource "oci_containerengine_node_pool" "node_pool_arm" {
  compartment_id     = oci_identity_compartment.compartment.id
  cluster_id         = oci_containerengine_cluster.oke_cluster.id
  kubernetes_version = var.oke_kubernetes_version
  name               = "np-arm-free"
  node_shape         = "VM.Standard.A1.Flex"

  node_config_details {
    placement_configs {
      availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
      subnet_id           = oci_core_subnet.sn_oke_nodes_priv.id
    }
    size          = var.node_pool_arm_size
    freeform_tags = var.tags
  }

  node_source_details {
    image_id    = data.oci_core_images.oke_arm_images.images[0].id
    source_type = "IMAGE"
  }

  node_shape_config {
    memory_in_gbs = var.node_pool_arm_memory
    ocpus         = var.node_pool_arm_ocpus
  }

  freeform_tags = var.tags
}
