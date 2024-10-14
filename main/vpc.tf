resource "google_compute_network" "vpc_hub_prod_0" {
  project                 = google_project.proj_net_hub_prod_0.project_id
  name                    = "vpc-${google_project.proj_net_hub_prod_0.project_id}-0"
  auto_create_subnetworks = var.vpc_auto_create_subnets
  mtu                     = var.vpc_mtu

  depends_on = [
    google_project_service.proj_net_hub_prod_0_services
  ]
}


resource "google_compute_subnetwork" "subnet_prod_0_ane1" {
  project       = google_project.proj_net_hub_prod_0.project_id
  name          = "subnet-${google_project.proj_net_hub_prod_0.project_id}-ane1-0"
  network       = google_compute_network.vpc_hub_prod_0.id
  region        = var.gcp_region
  ip_cidr_range = var.subnet_ip_range[0]

  depends_on = [
    google_compute_network.vpc_hub_prod_0
  ]
}

resource "google_compute_shared_vpc_host_project" "vpc_hub_prod_0_host" {
  project = google_project.proj_net_hub_prod_0.project_id

  depends_on = [
    google_compute_network.vpc_hub_prod_0
  ]
}

resource "google_compute_shared_vpc_service_project" "vpc_hub_prod_0_service_0" {
  host_project    = google_compute_shared_vpc_host_project.vpc_hub_prod_0_host.project
  service_project = google_project.proj_infra_bapp1_prod_0.project_id

  depends_on = [
    google_compute_shared_vpc_host_project.vpc_hub_prod_0_host
  ]
}

# Global internal address range for private connectivity with Google Services
resource "google_compute_global_address" "pvc_ip_range" {
  name          = "ip-int-${var.business_app_1_app_vm_config.short_app_name}-pvc-0"
  project       = google_project.proj_net_hub_prod_0.project_id
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 24
  network       = google_compute_network.vpc_hub_prod_0.id

  depends_on = [
    google_compute_network.vpc_hub_prod_0
  ]
}

# Private VPC connect configuration for private Google services access
resource "google_service_networking_connection" "pvc_connection_0" {
  network = google_compute_network.vpc_hub_prod_0.id
  service = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [
    google_compute_global_address.pvc_ip_range.name
  ]

  depends_on = [
    google_compute_network.vpc_hub_prod_0
  ]
}
