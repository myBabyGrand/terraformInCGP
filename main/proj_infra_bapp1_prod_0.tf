resource "google_project" "proj_infra_bapp1_prod_0" {
  name            = "proj-infra-bapp1-prod-0"
  project_id      = "proj-infra-bapp1-prod-20240727"
  billing_account = var.billing_account
  folder_id       = google_folder.infrastructure.id
}


# Eabling the Cloud Resource Manager API
resource "google_project_service" "proj_infra_bapp1_prod_0_cre_service" {
  project                    = google_project.proj_infra_bapp1_prod_0.id
  service                    = "cloudresourcemanager.googleapis.com"
  disable_dependent_services = true
}

# Eabling the maining API and services
resource "google_project_service" "proj_infra_bapp1_prod_0_services" {
  count                      = length(var.proj_infra_bapp1_prod_0_services)
  project                    = google_project.proj_infra_bapp1_prod_0.id
  service                    = var.proj_infra_bapp1_prod_0_services[count.index]
  disable_dependent_services = true
}
