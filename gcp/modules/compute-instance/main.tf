resource "google_compute_instance" "domain-controller" {
  name         = "domain-controller"
  machine_type = "n1-standard-1"

  tags = ["dc"]

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    subnetwork = var.subnetwork-id
    access_config {
    }
  }
}

resource "google_compute_instance" "ca01" {
  name         = "ca01"
  machine_type = "n1-standard-1"

  tags = ["pki-lab"]

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    subnetwork = var.subnetwork-id
    access_config {
    }
  }
}
resource "google_compute_instance" "ca02" {
  name         = "ca02"
  machine_type = "n1-standard-1"

  tags = ["pki-lab"]

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    subnetwork = var.subnetwork-id
    access_config {
    }
  }
}

resource "google_compute_instance" "crl-ocsp-webserver" {
  name         = "crl-ocsp-webserver"
  machine_type = "n1-standard-1"

  tags = ["pki-lab", "web-server"]

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    subnetwork = var.subnetwork-id
    access_config {
    }
  }
}