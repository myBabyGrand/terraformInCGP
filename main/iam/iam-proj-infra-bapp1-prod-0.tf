locals {
  proj_infra_bapp1_prod_0_id = "proj-infra-bapp1-prod-20240727"
  bastion_host_vm_name       = "vm-${var.business_app_1_bastion_host_vm_config.vm_name}-prod-0"
  #   sa_vm_bapp1 = "sa-vm-bapp1@${local.proj_infra_bapp1_prod_0_id}.iam.gserviceaccount.com"
  #   sa_cf_bapp1_cleaner = "sa-cf-bapp1-cleaner@${local.proj_infra_bapp1_prod_0_id}.iam.gserviceaccount.com"
}

# # Owners IAM role binding
# resource "google_project_iam_binding" "proj_infra_bapp1_prod_0_iam_owners" {
#   project = local.proj_infra_bapp1_prod_0_id
#   role    = "roles/owner"

#   members = [
#     "user:USER@EXAMPLE.COM",  # CHANGE THIS
#     "group:GROUP@EXAMPLE.COM" # CHANGE THIS
#   ]
# }

# # Editors
# resource "google_project_iam_binding" "proj_infra_bapp1_prod_0_iam_editors" {
#   project = local.proj_infra_bapp1_prod_0_id
#   role    = "roles/editor"

#   members = [
#     "user:USER@EXAMPLE.COM",                                               # CHANGE THIS
#     "group:GROUP@EXAMPLE.COM",                                             # CHANGE THIS
#     "serviceAccount:PROJECT_NUMBER-compute@developer.gserviceaccount.com", # CHANGE THIS
#     "serviceAccount:PROJECT_NUMBER@cloudservices.gserviceaccount.com",     # CHANGE THIS
#   ]
# }

# # Compute Admins
# resource "google_project_iam_binding" "proj_infra_bapp1_prod_0_iam_compute_admins" {
#   project = local.proj_infra_bapp1_prod_0_id
#   role    = "roles/compute.admin"

#   members = [
#     "user:USER@EXAMPLE.COM",  # CHANGE THIS
#     "group:GROUP@EXAMPLE.COM" # CHANGE THIS
#   ]
# }

##############################################################################
# Predefined roles
##############################################################################

# Compute Admins
resource "google_project_iam_binding" "proj_infra_bapp1_prod_0_iam_compute_admins" {
  project = local.proj_infra_bapp1_prod_0_id
  role    = "roles/compute.admin"

  members = [
    "user:USER@EXAMPLE.COM",  # CHANGE THIS
    "group:GROUP@EXAMPLE.COM" # CHANGE THIS
  ]
}

# IAP-Secured Tunnel User - Project - no conditions
resource "google_project_iam_binding" "proj_infra_bapp1_prod_0_iam_iap_tcp_tunnel" {
  project = local.proj_infra_bapp1_prod_0_id
  role    = "roles/iap.tunnelResourceAccessor"

  members = [
    "user:USER@EXAMPLE.COM",  # CHANGE THIS
    "group:GROUP@EXAMPLE.COM" # CHANGE THIS
  ]
}

# OS Login role - With conditions to match the VM name prefix
resource "google_project_iam_binding" "proj_infra_bapp1_prod_0_iam_os_login" {
  project = local.proj_infra_bapp1_prod_0_id
  role    = "roles/compute.osLogin"

  members = [
    "user:USER@EXAMPLE.COM",  # CHANGE THIS
    "group:GROUP@EXAMPLE.COM" # CHANGE THIS
  ]

  condition { # VERIFY THE VM NAME FOR THE CONDITION
    title       = "allowing_os_login_specific_vms"
    description = "Condition to allow OS Login to the specific VMs only"
    expression  = "resource.type == \"compute.googleapis.com/Instance\" && resource.name.startsWith(\"mvm-bapp1-\")"
  }
}

##############################################################################
# Custom roles assignments
##############################################################################

# Custom role - compute.instances.setMetadata role
resource "google_project_iam_binding" "proj_infra_bapp1_prod_0_iam_custom_setmetadata" {
  project = local.proj_infra_bapp1_prod_0_id
  role    = google_project_iam_custom_role.custom_setmetadata_role.id

  members = [
    "user:USER@EXAMPLE.COM",  # CHANGE THIS
    "group:GROUP@EXAMPLE.COM" # CHANGE THIS
  ]
}

##############################################################################
# VM Specific roles
##############################################################################

# VM Specific - IAP-Secured Tunnel User
resource "google_iap_tunnel_instance_iam_binding" "bastion_host_iap_bindings" {
  project  = local.proj_infra_bapp1_prod_0_id
  zone     = var.gcp_zone
  instance = local.bastion_host_vm_name
  role     = "roles/iap.tunnelResourceAccessor"

  members = [

  ]
}

resource "google_compute_instance_iam_binding" "bastion_host_oslogin_bindings" {
  project       = local.proj_infra_bapp1_prod_0_id
  zone          = var.gcp_zone
  instance_name = local.bastion_host_vm_name
  role          = "roles/compute.osLogin"

  members = [

  ]
}
