resource "google_project" "proj_infra_iam_test_0" {
  name            = "proj-infra-iam-test-0"
  project_id      = "proj-infra-iam-test-20240727"
  billing_account = var.billing_account
  folder_id       = google_folder.infrastructure.id

  depends_on = [
    google_folder.infrastructure
  ]
}


# Eabling the Cloud Resource Manager API
resource "google_project_service" "proj_infra_iam_test_0_crm_service" {
  project                    = google_project.proj_infra_iam_test_0.id
  service                    = "cloudresourcemanager.googleapis.com"
  disable_dependent_services = true

  depends_on = [
    google_project.proj_infra_iam_test_0
  ]
}

# Eabling the maining API and services
resource "google_project_service" "proj_infra_iam_test_0_services" {
  count                      = length(var.proj_infra_iam_test_0_services)
  project                    = google_project.proj_infra_iam_test_0.id
  service                    = var.proj_infra_iam_test_0_services[count.index]
  disable_dependent_services = true

  depends_on = [
    google_project_service.proj_infra_iam_test_0_crm_service
  ]
}
