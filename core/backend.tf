terraform {
  backend "gcs" {
    bucket      = "terraform-in-gcp-core-430313-bucket-tfstate"
    prefix      = "core/state"
    credentials = "..\\credentials\\mybabygrand-terraform-in-gcp-core.json"
  }
}
