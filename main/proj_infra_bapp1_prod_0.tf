resource "google_project" "proj_infra_bapp1_prod_0" {
  name            = "proj-infra-bapp1-prod-0"
  project_id      = "proj-infra-bapp1-prod-20240727"
  billing_account = var.billing_account
  folder_id       = google_folder.infrastructure.id
}
