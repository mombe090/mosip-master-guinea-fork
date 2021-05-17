provider "vsphere" {
  user           = "administrator@inu.gov.gn" #e.g randomuser@inu.gov.gn
  password       = "Wuri@2021" #e.g randompassword
  vsphere_server = "vcenter.inu.gov.gn" #e.g vcenter01@corp.local

  # If you have a self-signed cert
  allow_unverified_ssl = true
}
