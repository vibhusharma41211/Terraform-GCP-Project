resource google_compute_instance win_vm_instance {
    for_each = var.vm_name
    name = each.value
    zone = var.vm_specs.zone
    machine_type = var.vm_specs.machine_type
    metadata_startup_script = file("install_nginx.sh")

    boot_disk {
        initialize_params {
            image = var.vm_boot_disk.image
            size  = var.vm_boot_disk.size
            type  = var.vm_boot_disk.type
        }
    }
    
    tags = ["linux-vm", "testing", "http-server", "https-server", "lb-health-check"]
      
    # Default VPC + External Public IP
    network_interface {
        network = "default"

        access_config {
        }
    }

}

resource google_compute_disk data_disk_win_vm {
    for_each = var.vm_name
    name = "${each.value}-disk"
    type = var.data_disk.type
    zone = var.data_disk.zone
    size = var.data_disk.size
}

resource google_compute_attached_disk attach_disk {
    for_each = var.vm_name
    disk = google_compute_disk.data_disk_win_vm[each.value].id
    instance = google_compute_instance.win_vm_instance[each.value].id
}

# All Firewall Rules
resource "google_compute_firewall" "allow_http" {
    name    = "allow-http"
    network = "default"
    allow {
        protocol = "tcp"
        ports    = ["80"]
    }
    source_ranges = ["0.0.0.0/0"]
    target_tags   = ["http-server"]
}

resource "google_compute_firewall" "allow_https" {
    name    = "allow-https"
    network = "default"
    allow {
        protocol = "tcp"
        ports    = ["443"]
    }
    source_ranges = ["0.0.0.0/0"]
    target_tags   = ["https-server"]
}

resource "google_compute_firewall" "allow_lb_health_check" {
    name    = "allow-lb-health-check"
    network = "default"
    allow {
        protocol = "tcp"
    }
    source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
    target_tags = ["lb-health-check"]
}
