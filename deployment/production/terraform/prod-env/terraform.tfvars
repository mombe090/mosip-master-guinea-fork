# Provider
provider_vsphere_host     = "vcenter.inu.gov.gn"
#provider_vsphere_host     = "192.168.9.10"
provider_vsphere_user     = "administrator@inu.gov.gn"
provider_vsphere_password = "Wuri@2021"

# Infrastructure
deploy_vsphere_datacenter = "WURI-DC"
deploy_vsphere_cluster    = "GUINEE"
deploy_vsphere_datastore  = "SharedDatastore"
deploy_vsphere_folder     = "k8s"
deploy_vsphere_network    = "VMKernel"

# Guest
guest_name_prefix     = "k8s-prod"
guest_name_suffix    = ".inu.gov.gn"
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
mzmaster_ip = "192.168.9.130"
dmzmaster_ip = "192.168.9.140"


# Worker(s)
mzworker_ips = {
  "0" = "192.168.9.111"
  "1" = "192.168.9.112"
  "2" = "192.168.9.113"
  "3" = "192.168.9.114"
  "4" = "192.168.9.115"
  "5" = "192.168.9.116"
  "6" = "192.168.9.117"
  "7" = "192.168.9.118"
  "8" = "192.168.9.119"
  "9" = "192.168.9.120"
  "10" = "192.168.9.121"
  "11" = "192.168.9.122"
}

dmzworker_ips = {
  "0" = "192.168.9.127"
  "1" = "192.168.9.128"
  "2" = "192.168.9.129"
}

abis_ips = {
  "0" = "192.168.9.101"
  "1" = "192.168.9.102"
}

reporter_ips =  "192.168.9.103"
console_ip =  "192.168.9.110"
nfs_ip =  "192.168.9.135"


#, 197.149.224.10, 197.149.225.11
