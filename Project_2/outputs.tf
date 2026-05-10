locals {
	private_ip = google_compute_instance.win_vm_instance.network_interface[0].network_ip
	public_ip = google_compute_instance.win_vm_instance.network_interface[0].access_config[0].nat_ip
}

output "vm_private_ip" {
	value = local.private_ip
}

output "vm_public_ip" {
	value = local.public_ip
}
