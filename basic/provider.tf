provider "google" {
  # project     = "tf-state-bucket-429414"
  # credentials = "credentials\\tf-state-bucket.json"
  # region      = "asia-northeast3"
  # zone        = "asia-northeast3-a"
  project     = var.project_id
  credentials = file(var.credentials_file)
  region      = var.gcp_region
  zone        = var.gcp_zone
}
