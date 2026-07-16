###Required###
tenancy_ocid       = ""
region             = ""
budget_alert_email = ""

###Optional###
##Compartment##
compartment_name        = "oci-free"
compartment_description = "Compartment for OCI Free Tier resources"

##Network##
vcn_cidr_block                 = "10.0.0.0/16"
vcn_display_name               = "vcn-oci-free"
vcn_dns_label                  = "ocifree"
sn_oke_svc_pub_cidr            = "10.0.0.0/24"
sn_oke_svc_pub_display_name    = "sn-oke-svc-pub"
sn_oke_svc_pub_dns_label       = "snokesvcpub"
sn_oke_api_priv_cidr           = "10.0.1.0/24"
sn_oke_api_priv_display_name   = "sn-oke-api-priv"
sn_oke_api_priv_dns_label      = "snokeapipriv"
sn_oke_nodes_priv_cidr         = "10.0.2.0/24"
sn_oke_nodes_priv_display_name = "sn-oke-nodes-priv"
sn_oke_nodes_priv_dns_label    = "snokenodespriv"

##OKE##
oke_cluster_name       = "oke-free"
oke_kubernetes_version = "v1.34.2"

##Node Pool ARM
node_pool_arm_size   = 1
node_pool_arm_memory = 12
node_pool_arm_ocpus  = 2

tags = {
  environment = "free"
  managed_by  = "terraform"
}
