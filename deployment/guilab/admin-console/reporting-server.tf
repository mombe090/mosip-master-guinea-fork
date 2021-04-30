resource "vsphere_virtual_machine" "reportsrver" {
  name             = "reportsrver${var.guest_name_suffix}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder = vsphere_folder.extra_vm.path

  num_cpus = var.guest_vcpu
  memory   = var.guest_memory
  guest_id = "centos7_64Guest"
  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "disk0"
    size  = 800
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options{
        host_name =  "reportsrver"
        # domain = "wuriguinee.unir"
        domain = ""
      }
      network_interface {
        ipv4_address = var.reporter_ips
        ipv4_netmask = "24"
      }

      ipv4_gateway = var.guest_ipv4_gateway
      dns_suffix_list = ["wuriguinee.unir"]
      dns_server_list = var.guest_dns_servers
    }
  }

  boot_delay = 10000


  provisioner "remote-exec" {
    inline = ["echo \"$USER ALL=(ALL)  NOPASSWD: ALL\" >> /etc/sudoers"]

    connection {
      type     = "ssh"
      user     = "root"
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
