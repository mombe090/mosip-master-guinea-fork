# Provider
provider_vsphere_host     = "vcenter.wuriguinee.unir"
provider_vsphere_user     = "administrator@vsphere.local"
provider_vsphere_password = "Wuri@2021"

# Infrastructure
deploy_vsphere_datacenter = "WURI-DC"
deploy_vsphere_cluster    = "GUINEE"
deploy_vsphere_datastore  = "datastoreHote2"
deploy_vsphere_folder     = "k8s"
deploy_vsphere_network    = "VMKernel"

# Guest
guest_name_prefix     = "k8s-prod"
guest_name_suffix    = ".wuriguinee.unir"
guest_template        = "centos-clone1"
guest_vcpu            = "4"
guest_memory          = "16"
guest_ipv4_netmask    = "24"
guest_ipv4_gateway    = "192.168.9.1"
guest_dns_servers     = ["192.168.9.254", "192.168.9.1", "8.8.8.8"]
guest_dns_suffix      = "wuri.unir"
guest_domain          = ""
guest_ssh_user        = "centos"
guest_ssh_password    = "Wuri@2021"
guest_ssh_key_private = "~/.ssh/id_ed25519"
guest_ssh_key_public  = "~/.ssh/id_ed25519.pub"

# Master(s)
mzmaster_ips = {
  "0" = "192.168.9.70"
}

dmzmaster_ips = {
  "0" = "192.168.9.71"
}

# Worker(s)
mzworker_ips = {
  "0" = "192.168.9.75"
  #"1" = "192.168.9.76"
  #"2" = "192.168.9.77"
  #"3" = "192.168.9.78"
}

dmzworker_ips = {
  "0" = "192.168.9.90"
  #"1" = "192.168.9.76"
  #"2" = "192.168.9.77"
  #"3" = "192.168.9.78"
}
