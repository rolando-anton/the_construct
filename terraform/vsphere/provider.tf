provider "vsphere" {
  vsphere_server       = var.vcsa
  user                 = var.vcsa_admin
  password             = var.vcsa_passwd
  allow_unverified_ssl = true
  version              = "1.24.0"
}
