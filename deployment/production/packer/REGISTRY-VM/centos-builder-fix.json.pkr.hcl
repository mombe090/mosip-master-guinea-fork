
variable "iso_url" {
  type    = string
  default = "[SharedDatastore] ISO/CentOS-7-x86_64-Minimal-2009.iso"
}

variable "vm-cpu-num" {
  type    = string
  default = "4"
}

variable "vm-disk-size" {
  type    = string
  default = "819200"
}

variable "vm-mem-size" {
  type    = string
  default = "16384"
}

variable "vm-name" {
  type    = string
  default = "REGISTRY-TEMPL"
}

variable "vsphere-cluster" {
  type    = string
  default = ""
}

variable "vsphere-datacenter" {
  type    = string
  default = ""
}

variable "vsphere-datastore" {
  type    = string
  default = "datastoreHote2"
}

variable "vsphere-network" {
  type    = string
  default = "VMKernel"
}

variable "vsphere-password" {
  type    = string
  default = ""
}

variable "vsphere-server" {
  type    = string
  default = ""
}

variable "vsphere-user" {
  type    = string
  default = ""
}

source "vsphere-iso" "centos_7" {
  CPUs                 = "${var.vm-cpu-num}"
  RAM                  = "${var.vm-mem-size}"
  RAM_reserve_all      = false
  boot_command         = ["<esc><wait>", "linux ks=hd:fd0:/ks.cfg<enter>"]
  boot_order           = "disk,cdrom,floppy"
  boot_wait            = "10s"
  cluster              = "${var.vsphere-cluster}"
  convert_to_template  = true
  datacenter           = "${var.vsphere-datacenter}"
  datastore            = "${var.vsphere-datastore}"
  disk_controller_type = ["pvscsi"]
  floppy_files         = ["ks.cfg"]
  guest_os_type        = "centos7_64Guest"
  insecure_connection  = "true"
  iso_paths            = ["${var.iso_url}"]
  network_adapters {
    network      = "${var.vsphere-network}"
    network_card = "vmxnet3"
  }
  notes        = "Build via Packer"
  password     = "${var.vsphere-password}"
  ssh_password = ""
  ssh_username = "root"
  storage {
    disk_size             = "${var.vm-disk-size}"
    disk_thin_provisioned = true
  }
  username       = "${var.vsphere-user}"
  vcenter_server = "${var.vsphere-server}"
  vm_name        = "${var.vm-name}"
  folder         = "TEMPLATES"
}

build {
  sources = ["source.vsphere-iso.centos_7"]
}
