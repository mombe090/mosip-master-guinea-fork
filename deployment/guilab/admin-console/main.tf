data "vsphere_datacenter" "dc" {
  name = "WURI-DC" #e.g Datacenter1
}

data "vsphere_datastore" "datastore" {
  name          = "SharedDatastore" #e.g Datastore1
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = "GUINEE" #e.g "Compute Cluster/Resources"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "VMKernel" #e.g VM Network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name = "CENTOS-7-TEMPL"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_folder" "folder" {
  path = "test-env"
  type = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
}

======
