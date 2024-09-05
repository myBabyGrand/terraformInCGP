# business-app-1 IGM
resource "google_compute_region_instance_group_manager" "business_app_1_igm" {
  name    = "igm-${var.business_app_1_app_vm_config.app_name}"
  project = google_project.proj_infra_bapp1_prod_0.project_id

  base_instance_name = "mvm-${var.business_app_1_app_vm_config.vm_name}"
  region             = var.gcp_region

  version {
    instance_template = google_compute_instance_template.business_app_1_app_vm_template.self_link_unique
  }

  target_size = 3

  named_port {
    name = "bapp1-fe-port"
    port = 8888
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.business_app_1_hc_igm.id
    initial_delay_sec = 300
  }

  #   update_policy {
  #     type                           = "PROACTIVE"
  #     instance_redistribution_type   = "PROACTIVE"
  #     minimal_action                 = "REPLACE"
  #     most_disruptive_allowed_action = "REPLACE"
  #     max_surge_fixed                = 3
  #     max_unavailable_fixed          = 0
  #     replacement_method             = "SUBSTITUTE"
  #   }

  #   depends_on = [
  #     google_compute_instance_template.business_app_1_app_vm_template
  #   ]
}
