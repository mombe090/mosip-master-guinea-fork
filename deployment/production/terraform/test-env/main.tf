data "vsphere_datacenter" "dc" {
  name = var.deploy_vsphere_datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.deploy_vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.deploy_vsphere_cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.deploy_vsphere_network #e.g VM Network
  datacenter_id = data.vsphere_datacenter.dc.id
}

/*data "vsphere_virtual_machine" "template_k8s" {
  name = "TEST-K8S-TEMPL"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template_extra" {
  name = "TEST-EXTRA-VM"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template_console" {
  name = "TEST-CONSOLE-TEMPL"
  datacenter_id = data.vsphere_datacenter.dc.id
}

*/
resource "vsphere_folder" "parent" {
  path          = "mosip-test-env"
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
