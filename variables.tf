variable "tenancy_ocid" {
  description = "OCI Tenancy OCID"
  type        = string
}

variable "compartment_name" {
  description = "Name for the new compartment"
  type        = string
}

variable "compartment_description" {
  description = "Description for the new compartment"
  type        = string
}

variable "region" {
  description = "OCI Region"
  type        = string
}

variable "vcn_cidr_block" {
  description = "CIDR block for VCN"
  type        = string
}

variable "vcn_display_name" {
  description = "Display name for VCN"
  type        = string
}

variable "vcn_dns_label" {
  description = "DNS label for VCN"
  type        = string
}

variable "sn_oke_svc_pub_cidr" {
  description = "CIDR block for OKE services public subnet"
  type        = string
}

variable "sn_oke_svc_pub_display_name" {
  description = "Display name for OKE services public subnet"
  type        = string
}

variable "sn_oke_svc_pub_dns_label" {
  description = "DNS label for OKE services public subnet"
  type        = string
}

variable "sn_oke_api_priv_cidr" {
  description = "CIDR block for OKE API private subnet"
  type        = string
}

variable "sn_oke_api_priv_display_name" {
  description = "Display name for OKE API private subnet"
  type        = string
}

variable "sn_oke_api_priv_dns_label" {
  description = "DNS label for OKE API private subnet"
  type        = string
}

variable "sn_oke_nodes_priv_cidr" {
  description = "CIDR block for OKE nodes private subnet"
  type        = string
}

variable "sn_oke_nodes_priv_display_name" {
  description = "Display name for OKE nodes private subnet"
  type        = string
}

variable "sn_oke_nodes_priv_dns_label" {
  description = "DNS label for OKE nodes private subnet"
  type        = string
}

variable "tags" {
  description = "Freeform tags for resources"
  type        = map(string)
}

variable "oke_cluster_name" {
  description = "Name of the OKE cluster"
  type        = string
}

variable "oke_kubernetes_version" {
  description = "Kubernetes version for OKE cluster"
  type        = string
}

variable "node_pool_arm_size" {
  description = "Number of nodes in ARM node pool"
  type        = number
  default     = 2
}

variable "node_pool_arm_memory" {
  description = "Memory in GB for ARM nodes"
  type        = number
  default     = 12
}

variable "node_pool_arm_ocpus" {
  description = "OCPUs for ARM nodes"
  type        = number
  default     = 2
}

variable "budget_alert_email" {
  description = "Email address to receive budget alerts"
  type        = string
}
