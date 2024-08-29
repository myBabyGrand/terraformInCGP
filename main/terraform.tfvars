project_id       = "terraform-in-gcp-core-430313"
credentials_file = "..\\credentials\\mybabygrand-terraform-in-gcp-core.json"
gcp_region       = "asia-northeast3"
gcp_zone         = "asia-northeast3-a"
organization_id  = "931662760322"
billing_account  = "014C15-BF180E-E39C66"

#VPC
subnet_ip_range = [
  "10.0.1.0/24", # subnet_prod_0_ane1
  "10.0.2.0/24",
]
vpc_auto_create_subnets = false
vpc_mtu                 = 1460

proj_infra_bapp1_prod_0_services = [
  "compute.googleapis.com",
]

proj_net_hub_prod_0_services = [
  "compute.googleapis.com",
  "sql-component.googleapis.com",
  "sqladmin.googleapis.com",
]
