resource "vsphere_virtual_machine" "prod_nfserver" {
  name             = "prod.nfserver${var.guest_name_suffix}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder = vsphere_folder.storage.path

  num_cpus = var.guest_vcpu
  memory   = var.guest_memory
  guest_id = "centos7_64Guest"
  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "disk0"
    size  = 800
    eagerly_scrub    = data.vsphere_virtual_machine.prod_template_k8s.disks[0].eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.prod_template_k8s.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.prod_template_k8s.id

    customize {
      linux_options{
        host_name =  "prod-nfserver"
        # domain = "wuriguinee.unir"
        domain = ""
      }
      network_interface {
        ipv4_address = var.nfs_ip
        ipv4_netmask = "24"
      }

      ipv4_gateway = var.guest_ipv4_gateway
      dns_suffix_list = ["wuriguinee.unir"]
      dns_server_list = var.guest_dns_servers
    }
  }

  boot_delay = 5000

  provisioner "file" {
    source = "~/.ssh/id_rsa.pub"
    destination = "/tmp/id_rsa.pub"
    connection {
      type     = "ssh"
      user     = "root"
      password = var.root_ssh_password
      host     = self.guest_ip_addresses[0]
    }
  }

  provisioner "file" {
    source = "scripts/kube_auth.sh"
    destination = "/tmp/kube_auth.sh"
    connection {
      type     = "ssh"
      user     = "root"
      password = var.root_ssh_password
      host     = self.guest_ip_addresses[0]
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/kube_auth.sh",
      format("%s %s", "sudo /tmp/kube_auth.sh", "prod-nfserver")
    ]
  }
    connection {
      type     = "ssh"
      user     = "root"
      password = var.root_ssh_password
      host     = self.guest_ip_addresses[0]
    }

  lifecycle {
    ignore_changes = [annotation]
  }
}
