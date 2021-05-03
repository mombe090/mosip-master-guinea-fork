
resource "vsphere_virtual_machine" "dmzworkers" {
  count            = length(var.dmzworker_ips)
  name             = "test.dmzworker${count.index}${var.guest_name_suffix}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder = vsphere_folder.dmz_nodes.path

  num_cpus = var.guest_vcpu
  memory   = var.guest_memory
  guest_id = "centos7_64Guest"
  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "disk0"
    size  = var.k8s_node_memory
    eagerly_scrub    = data.vsphere_virtual_machine.template_k8s.disks[0].eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template_k8s.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template_k8s.id

    customize {
      linux_options{
        host_name =  "test-dmzworker${count.index}"
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
      format("%s %s", "sudo /tmp/kube_auth.sh", "test-dmzworker${count.index}")
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
