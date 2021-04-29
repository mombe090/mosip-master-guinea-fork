##### Data sources
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
  name          = var.deploy_vsphere_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.guest_template
  datacenter_id = data.vsphere_datacenter.dc.id
}


##### Resources
# Clones a single Linux VM from a template
resource "vsphere_virtual_machine" "mzk8s_master" {
  count            = length(var.mzmaster_ips)
  name             = "mzmaster"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  #folder           = vsphere_folder.folder.id

  num_cpus = var.guest_vcpu
  memory   = var.guest_memory
  guest_id = "centos7_64Guest"

  #scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.network.id
    #adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = "300"
    #eagerly_scrub    = data.vsphere_virtual_machine.template.disks[0].eagerly_scrub
    #thin_provisioned = data.vsphere_virtual_machine.template.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options{
        host_name =  "terraform-test-2"
        # domain = "wuriguinee.unir"
        domain = ""
      }
      network_interface {
        ipv4_address = "192.168.9.173"
        ipv4_netmask = "24"
      }

      ipv4_gateway = "192.168.9.1"
      dns_suffix_list = ["wuriguinee.unir"]
      dns_server_list = ["192.168.9.254", "192.168.9.1", "8.8.8.8"]
    }
  }

 /* clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = "mzmaster"
        domain    = var.guest_domain
      }

      network_interface {
        ipv4_address = lookup(var.mzmaster_ips, count.index)
        ipv4_netmask = var.guest_ipv4_netmask
      }

      ipv4_gateway    = var.guest_ipv4_gateway
      dns_server_list = var.guest_dns_servers
      dns_suffix_list = []
    }
  }*/

  #boot_delay = 10000

  # Remove existing SSH known hosts as remote identification (host key) changes between deployments.
  /*provisioner "local-exec" {
    command = "ssh-keygen -R ${self.guest_ip_addresses[0]}"
  }*/

  # Ansible requires Python to be installed on the remote machines (as well as the local machine).
  /*provisioner "remote-exec" {
    inline = ["sudo yum update -y"]

    connection {
      type     = "ssh"
      user     = var.guest_ssh_user
      password = var.guest_ssh_password
      host     = self.guest_ip_addresses[0]
    }
  }*/

  # Disabling SSH authenticity checking StrictHostKeyChecking=no, to avoid beeing asked to add RSA key fingerprint of a host when you access it for the first time.

  /*provisioner "local-exec" {
    command = "sshpass -p ${var.guest_ssh_password} ssh-copy-id -i ${var.guest_ssh_key_public} -o StrictHostKeyChecking=no ${var.guest_ssh_user}@${self.guest_ip_addresses[0]}"
  }*/

  # Prepare operating system for kubernetes using Ansible
  #provisioner "local-exec" {
  #  command = "ansible-playbook -i '${self.guest_ip_addresses[0]},' --private-key ${var.guest_ssh_key_private} ../ansible/k8s-preparation.yml"
  #}

  /*lifecycle {
    ignore_changes = [annotation]
  }*/
}

