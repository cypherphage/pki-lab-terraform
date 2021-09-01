provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_compute_network" "pki-network" {
  name                    = "pki-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "pki-subnet" {
  name          = "pki-subnet"
  ip_cidr_range = "192.168.10.0/24"
  network       = google_compute_network.pki-network.id
}

resource "google_compute_instance" "domain-controller" {
  name         = "domain-controller"
  machine_type = "n1-standard-1"

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.pki-subnet.id
    access_config {
    }
  }
}

resource "google_compute_firewall" "allow-rdp" {
  name = "allow-rdp"
  network = google_compute_network.pki-network.id
  source_ranges = [ var.myip ]
  allow {
    protocol = "tcp"
    ports = ["3389"]
  }
  
}