provider "vsphere" {
  user           = "administrator@inu.gov.gn"
  password       = "Wuri@2021" 
  vsphere_server = "vcenter.inu.gov.gn" 

  # If you have a self-signed cert
  allow_unverified_ssl = true
}
