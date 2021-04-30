# Provider
#provider_vsphere_host     = "vcenter.wuriguinee.unir"
provider_vsphere_host     = "192.168.9.100"
provider_vsphere_user     = "administrator@vsphere.local"
provider_vsphere_password = "Wuri@2021"

# Infrastructure
deploy_vsphere_datacenter = "WURI-DC"
deploy_vsphere_cluster    = "GUINEE"
deploy_vsphere_datastore  = "SharedDatastore"
deploy_vsphere_folder     = "k8s"
deploy_vsphere_network    = "VMKernel"

# Guest
guest_name_prefix     = "k8s-prod"
guest_name_suffix    = ".wuriguinee.unir"
guest_template        = "CENTOS-7-TEMPL"
guest_vcpu            = 4
guest_memory          = 16384
guest_ipv4_netmask    = "24"
guest_ipv4_gateway    = "192.168.9.1"
guest_dns_servers     = ["192.168.9.254", "197.149.224.10", "197.149.225.11"]
guest_dns_suffix      = "wuri.unir"
guest_domain          = ""
guest_ssh_user        = "centos"
guest_ssh_password    = "Wuri@2021"
guest_ssh_key_private = "~/.ssh/id_rsa"
guest_ssh_key_public  = "~/.ssh/id_rsa.pub"

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
  "1" = "192.168.9.76"
  /*"2" = "192.168.9.77"
  "3" = "192.168.9.78"
  "4" = "192.168.9.78"
  "5" = "192.168.9.78"
  "6" = "192.168.9.78"
  "7" = "192.168.9.78"
  "8" = "192.168.9.78"
  "0" = "192.168.9.78"
  "10" = "192.168.9.78"
  "11" = "192.168.9.78"
  "12" = "192.168.9.78"
  "13" = "192.168.9.78"
  "14" = "192.168.9.78"
  "15" = "192.168.9.78"
  "16" = "192.168.9.78"*/
}

dmzworker_ips = {
  "0" = "192.168.9.90"
  #"1" = "192.168.9.91"
  #"2" = "192.168.9.77"
  #"3" = "192.168.9.78"
}

abis_ips = {
  "0" = "192.168.9.101"
  "1" = "192.168.9.101"
  #"2" = "192.168.9.77"
  #"3" = "192.168.9.78"
}

reporter_ips =  "192.168.9.103"


#, 197.149.224.10, 197.149.225.11
