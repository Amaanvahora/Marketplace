provider "google" {
  credentials = file("/mnt/e/Projects/Marketplace/Marketplace/theta-turbine-417512-2aa4a7243d0b.json")
  project     = "theta-turbine-417512"
  region      = "us-central1"
}
resource "google_container_cluster" "primary" {
  name               = "nft-marketplace-cluster"
  location           = "us-central1"
  remove_default_node_pool = true
  initial_node_count = 1

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "primary-node-pool"
  location   = "us-central1"
  cluster    = google_container_cluster.primary.name

  node_count = 1

  node_config {
    preemptible  = false
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_write",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
    ]
  }
}