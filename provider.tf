terraform {
  backend "local" {
    path = "state/terraform.tfstate"
  }
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "8.1.0"
    }
  }
}

provider "oci" {
  region = var.region
}
