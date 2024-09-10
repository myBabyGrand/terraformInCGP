#Database vm
resource "google_compute_instance" "bapp_1_db_vm" {
  project      = google_project.proj_infra_bapp1_prod_0.project_id
  name         = "vm-${var.business_app_1_db_vm_config.vm_name}-prod-0"
  machine_type = var.business_app_1_db_vm_config.vm_type
  zone         = var.gcp_zone
  tags         = var.business_app_1_db_vm_config.vm_tags

  labels = {
    enviroment     = "prod"
    app-name       = var.business_app_1_db_vm_config.app_name
    app-short-name = var.business_app_1_db_vm_config.short_app_name
    vm-role        = "app"
  }

  boot_disk {
    initialize_params {
      image = var.business_app_1_db_vm_config.vm_image
      size  = var.business_app_1_db_vm_config.boot_disk_size
      type  = var.business_app_1_db_vm_config.vm_boot_disk_type
    }
  }

  metadata_startup_script = var.business_app_1_db_vm_config.vm_startup_script

  network_interface {
    subnetwork = google_compute_subnetwork.subnet_prod_0_ane1.id

    #getting public ip
    # access_config {
    #   # Include this section to give the VM an external IP address
    # }
  }

  service_account {
    scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/pubsub",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
    ]
  }

  scheduling {
    preemptible        = true
    automatic_restart  = false
    provisioning_model = "SPOT"
  }

  lifecycle {
    ignore_changes = [
      scheduling[0].instance_termination_action
    ]
  }
}

