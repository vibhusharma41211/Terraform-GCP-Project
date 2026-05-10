variable "vm_specs" {
  type = object({
    name         = string
    location     = string
    zone         = string
    machine_type = string
  })

  default = {
    name         = "win-vm-automatic"
    location     = "asia-south2"
    zone         = "asia-south2-b"
    machine_type = "e2-medium"
  }
}

variable "vm_boot_disk" {
  type = object({
    image = string
    size  = number
    type  = string
  })

  default = {
    image = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
    size  = 10
    type  = "pd-balanced"
  }
}

variable "data_disk" {
  type = object({
    name = string
    type = string
    zone = string
    size = number
  })

  default = {
    name = "win-vm-automatic-disk1"
    type = "pd-ssd"
    zone = "asia-south2-b"
    size = 100
  }
}
