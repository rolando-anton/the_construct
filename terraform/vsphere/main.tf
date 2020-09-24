module "vapp" {
  source    = "rolando-anton/vapp/vsphere"
  version   = "1.0.2"
  dc        = "Home"
  vmrp      = "/Home/host/Aiur"
  vapp_name = "APT29"
}

module "dmevals-internal" {
  source  = "rolando-anton/distributed_portgroup/vsphere"
  version = "1.0.6"
  dc = "Home"
  portgroup-name = "dmevals-internal"
  vswitch = "ds-cloud"
}

module "dmevals-corp" {
  source  = "rolando-anton/distributed_portgroup/vsphere"
  version = "1.0.6"
  dc = "Home"
  portgroup-name = "dmevals-corp"
  vswitch = "ds-cloud"
}

module "dmevals-attacker" {
  source  = "rolando-anton/distributed_portgroup/vsphere"
  version = "1.0.6"
  dc = "Home"
  portgroup-name = "dmevals-attacker"
  vswitch = "ds-cloud"
}


module "fpoc" {
  source  = "rolando-anton/simplevm/vsphere"
  version = "1.2.0"
  vm_depends_on          = [module.vapp]
  vmtemp              = "windows_10-1903-aws"
  instances           = 1
  vmname              = "newyork"
  vmrp                = module.vapp.vapp-id
  nested_hv_enabled = false
  network_cards       = [ module.dmevals-corp.portgroup-name ]
  cpu_number          = 4
  ram_size            = 4096
  datastore           = "NVMe01"
  data_disk_datastore = [ "NVMe01" ]
network_type        = ["vmxnet3"]
  ipv4 = {
  }
  dc = "Home"
}

