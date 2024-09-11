resource "google_project" "proj_infra_bapp1_prod_0" {
  name            = "proj-infra-bapp1-prod-0"
  project_id      = "proj-infra-bapp1-prod-20240727"
  billing_account = var.billing_account
  folder_id       = google_folder.infrastructure.id

  depends_on = [
    google_folder.infrastructure
  ]
}


# Eabling the Cloud Resource Manager API
resource "google_project_service" "proj_infra_bapp1_prod_0_crm_service" {
  project                    = google_project.proj_infra_bapp1_prod_0.id
  service                    = "cloudresourcemanager.googleapis.com"
  disable_dependent_services = true

  depends_on = [
    google_project.proj_infra_bapp1_prod_0
  ]
}

# Eabling the maining API and services
resource "google_project_service" "proj_infra_bapp1_prod_0_services" {
  count                      = length(var.proj_infra_bapp1_prod_0_services)
  project                    = google_project.proj_infra_bapp1_prod_0.id
  service                    = var.proj_infra_bapp1_prod_0_services[count.index]
  disable_dependent_services = true

  depends_on = [
    google_project_service.proj_infra_bapp1_prod_0_crm_service
  ]
}

# Budget alert for the project
resource "google_billing_budget" "proj_infra_bapp1_prod_0_budget" {
  billing_account = var.billing_account
  display_name    = "budget-${google_project.proj_infra_bapp1_prod_0.project_id}"

  budget_filter {
    projects = ["projects/${google_project.proj_infra_bapp1_prod_0.number}"]
  }

  amount {
    specified_amount {
      currency_code = "KRW"
      units         = "400000"
    }
  }

  threshold_rules {
    threshold_percent = 0.25
  }
  threshold_rules {
    threshold_percent = 0.50
  }
  threshold_rules {
    threshold_percent = 0.75
  }
  threshold_rules {
    threshold_percent = 1.0
  }
  threshold_rules {
    threshold_percent = 0.9
    spend_basis       = "FORECASTED_SPEND"
  }

  all_updates_rule {
    monitoring_notification_channels = [
      google_monitoring_notification_channel.proj_infra_bapp1_prod_0_notification_channel_1.id,
      google_monitoring_notification_channel.proj_infra_bapp1_prod_0_notification_channel_2.id
    ]
    disable_default_iam_recipients = true
  }

  depends_on = [
    google_project.proj_infra_bapp1_prod_0
  ]
}

# Project notification channels (email)
resource "google_monitoring_notification_channel" "proj_infra_bapp1_prod_0_notification_channel_1" {
  project      = google_project.proj_infra_bapp1_prod_0.project_id
  display_name = "6pmfriday@gmail.com" # CHANGE THIS
  type         = "email"

  labels = {
    email_address = "6pmfriday@gmail.com" # CHANGE THIS
  }

  depends_on = [
    google_project.proj_infra_bapp1_prod_0
  ]
}

# Project notification channels (email)
resource "google_monitoring_notification_channel" "proj_infra_bapp1_prod_0_notification_channel_2" {
  project      = google_project.proj_infra_bapp1_prod_0.project_id
  display_name = "amuro_ray@kakao.com"
  type         = "email"

  labels = {
    email_address = "amuro_ray@kakao.com" # CHANGE THIS
  }

  depends_on = [
    google_project.proj_infra_bapp1_prod_0
  ]
}
