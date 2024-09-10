# NAT IP
resource "google_compute_address" "vpc_hub_prod_0_nat_ext_ip" {
  name    = "ip-ext-${google_compute_network.vpc_hub_prod_0.name}-nat-gw-ane1"
  project = google_project.proj_net_hub_prod_0.project_id
  region  = var.gcp_region

  # depends_on = [
  #   google_compute_network.vpc_hub_prod_0
  # ]
}

# Cloud Router
resource "google_compute_router" "vpc_hub_prod_0_nat_router" {
  name    = "rtr-${google_compute_network.vpc_hub_prod_0.name}-nat-ane1-0"
  project = google_project.proj_net_hub_prod_0.project_id
  region  = var.gcp_region
  network = google_compute_network.vpc_hub_prod_0.id

  # depends_on = [
  #   google_compute_network.vpc_hub_prod_0
  # ]
}

# NAT GW
resource "google_compute_router_nat" "vpc_hub_prod_0_nat_nat_gw" {
  name    = "nat-gw-${google_compute_network.vpc_hub_prod_0.name}-ane1-0"
  project = google_project.proj_net_hub_prod_0.project_id
  region  = var.gcp_region

  router = google_compute_router.vpc_hub_prod_0_nat_router.name

  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips = [
    google_compute_address.vpc_hub_prod_0_nat_ext_ip.self_link
  ]

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.subnet_prod_0_ane1.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  # depends_on = [
  #   google_compute_router.vpc_hub_prod_0_nat_router,
  #   google_compute_subnetwork.subnet_prod_0_ane1
  # ]
}
