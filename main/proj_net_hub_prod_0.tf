resource "google_project" "proj_net_hub_prod_0" {
  name            = "proj-net-hub-prod-0"
  project_id      = "proj-net-hub-prod-20240727"
  billing_account = var.billing_account
  folder_id       = google_folder.network.id
}
