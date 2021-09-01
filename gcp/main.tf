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