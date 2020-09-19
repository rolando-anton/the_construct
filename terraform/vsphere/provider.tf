terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "1.24.0"
    }
  }
}


provider "vsphere" {
  vsphere_server       = var.vcsa
  user                 = var.vcsa_admin
  password             = var.vcsa_passwd
  allow_unverified_ssl = true
}
