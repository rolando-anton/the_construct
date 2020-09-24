provider "google" {
  project     = var.gcp-project
  region      = var.region
  credentials = "./gcp_keyfile.json"
}
