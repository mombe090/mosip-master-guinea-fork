# Provider
#provider_vsphere_host     = "vcenter.wuriguinee.unir"
provider_vsphere_host     = "192.168.9.100"
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
guest_template        = "CENTOS-7-TEMPL"
guest_vcpu            = 4
guest_memory          = 16384
k8s_node_memory       = 250
guest_ipv4_netmask    = "24"
guest_ipv4_gateway    = "192.168.9.1"
guest_dns_servers     = ["192.168.9.254", "197.149.224.10", "197.149.225.11"]
guest_dns_suffix      = "wuri.unir"
guest_domain          = ""
guest_ssh_user        = "centos"
guest_ssh_password    = "Wuri@2021"
root_ssh_password    = "Wuri2021@"
guest_ssh_key_private = "~/.ssh/id_rsa"
guest_ssh_key_public  = "~/.ssh/id_rsa.pub"

# Master(s)
mzmaster_ip = "192.168.9.138"
dmzmaster_ip = "192.168.9.139"

# Worker(s)
mzworker_ips = {
  "0" = "192.168.9.106"
  "1" = "192.168.9.107"
  "2" = "192.168.9.108"
  "3" = "192.168.9.109"
  "4" = "192.168.9.131"
  "5" = "192.168.9.132"
  "6" = "192.168.9.133"
  "7" = "192.168.9.134"
  "8" = "192.168.9.136"
  "9" = "192.168.9.137"
}

dmzworker_ips = {
  "0" = "192.168.9.141"
  "1" = "192.168.9.142"
}

abis_ips = {
  "0" = "192.168.9.104"
}

reporter_ips =  "192.168.9.105"
console_ip =  "192.168.9.145"


#, 197.149.224.10, 197.149.225.11
