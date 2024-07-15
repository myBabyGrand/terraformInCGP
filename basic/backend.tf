terraform {
  backend "gcs" {
    bucket      = "terrafom-in-gcp-tf-state"
    prefix      = "terraform/state"
    credentials = "credentials\\tf-state-bucket.json"
  }
}
