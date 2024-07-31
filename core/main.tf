resource "google_storage_bucket" "default" {
  name          = "${var.project_id}-bucket-tfstate"
  force_destroy = false
  location      = "ASIA"
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}

# Eabling the Cloud Resource Manager API
resource "google_project_service" "core_tf_project_crm_service" {
  project                    = var.project_id
  service                    = "cloudresourcemanager.googleapis.com"
  disable_dependent_services = true
}

# Eabling the maining API and services
resource "google_project_service" "core_tf_project_services" {
  count                      = length(var.core_tf_project_services)
  project                    = var.project_id
  service                    = var.core_tf_project_services[count.index]
  disable_dependent_services = true
}
