module "vapp" {
  source  = "rolando-anton/vapp/vsphere"
  version = "1.0.1"
  dc        = "Home"
  vmrp      = "/Home/host/Aiur"
  vapp_name = "Test01"
}

output "print-vapp" {
  value = module.vapp.vapp-name
}
