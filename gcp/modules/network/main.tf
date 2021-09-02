resource "google_compute_network" "pki-network" {
  name                    = "pki-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "pki-subnet" {
  name          = "pki-subnet"
  ip_cidr_range = "192.168.10.0/24"
  network       = google_compute_network.pki-network.id
}

resource "google_compute_firewall" "allow-rdp" {
  name          = "allow-rdp"
  network       = google_compute_network.pki-network.id
  source_ranges = [var.myip]
  target_tags   = ["dc", "pki-lab"]
  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }
}

resource "google_compute_firewall" "domain-controller" {
  name        = "domain-controller"
  network     = google_compute_network.pki-network.id
  source_tags = ["pki-lab"]
  target_tags = ["dc"]
  allow {
    protocol = "tcp"
    ports    = ["53", "88", "135", "139", "445", "464", "636", "873", "3269", "49152-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["53", "88", "123", "137", "138", "389", "445", "464", "49152-65535"]
  }
}