provider "vsphere" {
  user           = "administrator@vsphere.local" #e.g randomuser@vsphere.local
  password       = "Wuri@2021" #e.g randompassword
  vsphere_server = "vcenter.wuriguinee.unir" #e.g vcenter01@corp.local

  # If you have a self-signed cert
  allow_unverified_ssl = true
}
