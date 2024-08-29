output "proj_infra_bapp1_prod_0_number" {
  value = google_project.proj_infra_bapp1_prod_0.number
}

output "proj_infra_bapp1_prod_0_project_id" {
  value = google_project.proj_infra_bapp1_prod_0.project_id
}

output "proj_net_hub_prod_0_number" {
  value = google_project.proj_net_hub_prod_0.number
}

output "proj_net_hub_prod_0_project_id" {
  value = google_project.proj_net_hub_prod_0.project_id
}

#cloudbilling.googleapis.com

output "app_vm_internal_ip" {
  value = google_compute_instance.bapp_1_app_vm.network_interface[0].network_ip
}

output "db_vm_internal_ip" {
  value = google_compute_instance.bapp_1_db_vm.network_interface[0].network_ip
}

output "app_vm_external_ip" {
  value = google_compute_instance.bapp_1_app_vm.network_interface[0].access_config[0].nat_ip
}
