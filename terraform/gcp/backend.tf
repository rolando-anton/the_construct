terraform {
  backend "gcs" {
    bucket      = "fpoc-tfstate-gcp"
    prefix      = "gcp-latamcse"
    credentials = "./gcp_keyfile.json"
  }
}
