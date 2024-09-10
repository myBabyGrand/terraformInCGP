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


#VMs
business_app_1_app_vm_config = {
  app_name                = "business-app-1"
  short_app_name          = "bapp1"
  vm_name                 = "bapp1"
  vm_type                 = "e2-medium"
  vm_tags                 = ["bapp1", "prod", "app-fe"]
  vm_image                = "debian-cloud/debian-11"
  vm_boot_disk_type       = "pd-standard"
  boot_disk_size          = 10
  vm_startup_script       = "sudo apt-get update; sudo apt-get install -yq build-essential python3-pip rsync; pip install flask"
  autoscaler_min_replicas = 3
  autoscaler_max_replicas = 9
}


business_app_1_db_vm_config = {
  app_name          = "business-app-1"
  short_app_name    = "bapp1"
  vm_name           = "bapp1-db"
  vm_type           = "e2-medium"
  vm_tags           = ["bapp1", "prod", "be-db"]
  vm_image          = "debian-cloud/debian-11"
  vm_boot_disk_type = "pd-ssd"
  boot_disk_size    = 10
  vm_startup_script = "sudo apt-get update; sudo apt-get install -yq mariadb-server"
}

named_ports = {
  bapp1 = {
    port_name   = "bapp1-fe-port"
    port_number = 8888
  }
}
