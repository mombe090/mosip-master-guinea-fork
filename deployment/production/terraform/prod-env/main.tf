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

data "vsphere_virtual_machine" "prod_template_extra" {
  name = "PROD-EXTRA-VM-TEMPL"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "prod_template_k8s" {
  name = "PROD-K8S-VM-TEMPL"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_folder" "parent" {
  path          = "mosip-prod-env"
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
}


resource "vsphere_folder" "extra_vm" {
  path          = "${vsphere_folder.parent.path}/extra-vm"
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_folder" "k8s_vm" {
  path          = "${vsphere_folder.parent.path}/k8s-vm"
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_folder" "mz_nodes" {
  path          = "${vsphere_folder.k8s_vm.path}/mz-nodes"
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_folder" "dmz_nodes" {
  path          = "${vsphere_folder.k8s_vm.path}/dmz-nodes"
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_folder" "masters" {
  path          = "${vsphere_folder.k8s_vm.path}/masters"
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_folder" "storage" {
  path          = "${vsphere_folder.k8s_vm.path}/nfs"
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
}
