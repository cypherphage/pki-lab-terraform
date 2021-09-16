provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

module "network" {
  source = "./modules/network"
  myip = var.myip
}

module "compute-instance" {
  source = "./modules/compute-instance"
  subnetwork-id = module.network.subnetworkid
}




