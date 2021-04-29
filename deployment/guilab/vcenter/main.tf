data "vsphere_datacenter" "dc" {
  name = "WURI-DC" #e.g Datacenter1
}

data "vsphere_datastore" "datastore" {
  name          = "datastoreHote2" #e.g Datastore1
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
  name = "centos-clone1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "mzmasters" {
  count            = length(var.mzmaster_ips)
  name             = "mzmaster${count.index}${var.guest_name_suffix}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.guest_vcpu
  memory   = var.guest_memory
  guest_id = "centos7_64Guest"
  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "disk0"
    size  = 300
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options{
        host_name =  "mzmaster${count.index}"
        # domain = "wuriguinee.unir"
        domain = ""
      }
      network_interface {
        ipv4_address = lookup(var.mzmaster_ips, count.index)
        ipv4_netmask = "24"
      }

      ipv4_gateway = var.guest_ipv4_gateway
      dns_suffix_list = ["wuriguinee.unir"]
      dns_server_list = var.guest_dns_servers
    }
  }

  boot_delay = 10000

  provisioner "local-exec" {
    command = "ssh-keygen -R ${self.guest_ip_addresses[0]}"
  }

  provisioner "remote-exec" {
    inline = ["echo TOBECHANGE_BY_COMMANDS"]

    connection {
      type     = "ssh"
      user     = var.guest_ssh_user
      password = var.guest_ssh_password
      host     = self.guest_ip_addresses[0]
    }
  }

  provisioner "local-exec" {
    command = "sshpass -p ${var.guest_ssh_password} ssh-copy-id -i ${var.guest_ssh_key_public} -o StrictHostKeyChecking=no ${var.guest_ssh_user}@${self.guest_ip_addresses[0]}"
  }

  lifecycle {
    ignore_changes = [annotation]
  }
}

resource "vsphere_virtual_machine" "dmzmasters" {
  count            = length(var.dmzmaster_ips)
  name             = "dmzmaster${count.index}${var.guest_name_suffix}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.guest_vcpu
  memory   = var.guest_memory
  guest_id = "centos7_64Guest"
  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "disk0"
    size  = 300
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options{
        host_name =  "dmzmaster${count.index}"
        # domain = "wuriguinee.unir"
        domain = ""
      }
      network_interface {
        ipv4_address = lookup(var.dmzmaster_ips, count.index)
        ipv4_netmask = "24"
      }

      ipv4_gateway = var.guest_ipv4_gateway
      dns_suffix_list = ["wuriguinee.unir"]
      dns_server_list = var.guest_dns_servers
    }
  }

  boot_delay = 10000

  provisioner "local-exec" {
    command = "ssh-keygen -R ${self.guest_ip_addresses[0]}"
  }

  provisioner "remote-exec" {
    inline = ["echo TOBECHANGE_BY_COMMANDS"]

    connection {
      type     = "ssh"
      user     = var.guest_ssh_user
      password = var.guest_ssh_password
      host     = self.guest_ip_addresses[0]
    }
  }

  provisioner "local-exec" {
    command = "sshpass -p ${var.guest_ssh_password} ssh-copy-id -i ${var.guest_ssh_key_public} -o StrictHostKeyChecking=no ${var.guest_ssh_user}@${self.guest_ip_addresses[0]}"
  }

  lifecycle {
    ignore_changes = [annotation]
  }
}

resource "vsphere_virtual_machine" "mzworkers" {
  count            = length(var.mzworker_ips)
  name             = "mzworker${count.index}${var.guest_name_suffix}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.guest_vcpu
  memory   = var.guest_memory
  guest_id = "centos7_64Guest"
  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "disk0"
    size  = 300
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options{
        host_name =  "mzworker${count.index}"
        # domain = "wuriguinee.unir"
        domain = ""
      }
      network_interface {
        ipv4_address = lookup(var.mzworker_ips, count.index)
        ipv4_netmask = "24"
      }

      ipv4_gateway = var.guest_ipv4_gateway
      dns_suffix_list = ["wuriguinee.unir"]
      dns_server_list = var.guest_dns_servers
    }
  }

  boot_delay = 10000

  provisioner "local-exec" {
    command = "ssh-keygen -R ${self.guest_ip_addresses[0]}"
  }

  provisioner "remote-exec" {
    inline = ["echo TOBECHANGE_BY_COMMANDS"]

    connection {
      type     = "ssh"
      user     = var.guest_ssh_user
      password = var.guest_ssh_password
      host     = self.guest_ip_addresses[0]
    }
  }

  provisioner "local-exec" {
    command = "sshpass -p ${var.guest_ssh_password} ssh-copy-id -i ${var.guest_ssh_key_public} -o StrictHostKeyChecking=no ${var.guest_ssh_user}@${self.guest_ip_addresses[0]}"
  }

  lifecycle {
    ignore_changes = [annotation]
  }
}

resource "vsphere_virtual_machine" "dmzworkers" {
  count            = length(var.dmzworker_ips)
  name             = "dmzworker${count.index}${var.guest_name_suffix}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.guest_vcpu
  memory   = var.guest_memory
  guest_id = "centos7_64Guest"
  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "disk0"
    size  = 300
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options{
        host_name =  "dmzworker${count.index}"
        # domain = "wuriguinee.unir"
        domain = ""
      }
      network_interface {
        ipv4_address = lookup(var.dmzworker_ips, count.index)
        ipv4_netmask = "24"
      }

      ipv4_gateway = var.guest_ipv4_gateway
      dns_suffix_list = ["wuriguinee.unir"]
      dns_server_list = var.guest_dns_servers
    }
  }

  boot_delay = 10000

  provisioner "local-exec" {
    command = "ssh-keygen -R ${self.guest_ip_addresses[0]}"
  }

  provisioner "remote-exec" {
    inline = ["echo TOBECHANGE_BY_COMMANDS"]

    connection {
      type     = "ssh"
      user     = var.guest_ssh_user
      password = var.guest_ssh_password
      host     = self.guest_ip_addresses[0]
    }
  }

  provisioner "local-exec" {
    command = "sshpass -p ${var.guest_ssh_password} ssh-copy-id -i ${var.guest_ssh_key_public} -o StrictHostKeyChecking=no ${var.guest_ssh_user}@${self.guest_ip_addresses[0]}"
  }

  lifecycle {
    ignore_changes = [annotation]
  }

}
