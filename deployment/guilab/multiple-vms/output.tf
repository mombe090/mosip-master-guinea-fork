output "datacenter_id" {
  value = data.vsphere_datacenter.dc.id
}

output "cluster_id" {
  value = data.vsphere_compute_cluster.cluster.id
}

output "datastore_id" {
  value = data.vsphere_datastore.datastore.id
}

output "portgroup_id" {
  value = data.vsphere_network.network.id
}
