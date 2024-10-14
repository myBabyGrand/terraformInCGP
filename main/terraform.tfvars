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

proj_net_hub_prod_0_services = [
  "compute.googleapis.com",
  "servicenetworking.googleapis.com",
]


proj_infra_bapp1_prod_0_services = [
  "compute.googleapis.com",
  "sql-component.googleapis.com",
  "sqladmin.googleapis.com",
  "servicenetworking.googleapis.com",
  "iap.googleapis.com",
  "secretemanager.googleapis.com"
]



#VMs
business_app_1_app_vm_config = {
  app_name                = "business-app-1"
  short_app_name          = "bapp1"
  vm_name                 = "bapp1"
  vm_type                 = "e2-medium"
  vm_tags                 = ["bapp1", "prod", "app-fe", "tcp8888", "iap"]
  vm_image                = "debian-cloud/debian-11"
  vm_boot_disk_type       = "pd-standard"
  boot_disk_size          = 10
  vm_startup_script       = "sudo apt-get update; sudo apt-get install -yq build-essential python3-pip rsync; pip install flask"
  autoscaler_min_replicas = 3
  autoscaler_max_replicas = 9
  app_version             = "1.8"
}

# Bastion host variables
business_app_1_bastion_host_vm_config = {
  app_name          = "business-app-1"
  short_app_name    = "bapp1"
  vm_name           = "bapp1-bastion"
  vm_type           = "e2-medium"
  vm_tags           = ["bapp1", "prod", "bastion", "iap"]
  vm_image          = "debian-cloud/debian-11"
  vm_boot_disk_type = "pd-standard"
  boot_disk_size    = 10
  vm_startup_script = "sudo apt-get update; sudo apt-get install -yq mariadb-server"
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


# The Cloud SQL config for the bapp1
business_app_1_cloud_sql_config = {
  app_name                     = "business-app-1"
  short_app_name               = "bapp1"
  instance_tier                = "db-f1-micro"
  instance_disk_type           = "PD_HDD"
  instance_disk_size           = 10
  instance_disk_autoresize     = false
  instance_availability_type   = "ZONAL"
  instance_ipv4_enabled        = false
  instance_deletion_protection = false
}

proj_infra_iam_test_0_services = [
  "compute.googleapis.com",
  "sql-component.googleapis.com",
  "sqladmin.googleapis.com",
  "servicenetworking.googleapis.com",
]


# =============================================================================================
# Cloud Armor Policy Rules below
# =============================================================================================

cloud_armor_policies = {
  # SQL injection rule
  owasp_rule_sqli = {
    action      = "deny(403)"
    priority    = "1000"
    preview     = false
    expression  = "evaluatePreconfiguredExpr('sqli-v33-stable',['owasp-crs-v030301-id942251-sqli','owasp-crs-v030301-id942490-sqli','owasp-crs-v030301-id942420-sqli','owasp-crs-v030301-id942431-sqli','owasp-crs-v030301-id942460-sqli','owasp-crs-v030301-id942101-sqli','owasp-crs-v030301-id942511-sqli','owasp-crs-v030301-id942421-sqli','owasp-crs-v030301-id942432-sqli'])"
    description = "SQL injection rule sensitivity 2"
  }

  # Cross site scripting rule
  owasp_rule_xss = {
    action      = "deny(403)"
    priority    = "1001"
    preview     = false
    expression  = "evaluatePreconfiguredExpr('xss-v33-stable')"
    description = "Cross site scripting rule sensitivity 2"
  }

  # Local file inclusion rule
  owasp_rule_lfi = {
    action      = "deny(403)"
    priority    = "1002"
    preview     = false
    expression  = "evaluatePreconfiguredExpr('lfi-v33-stable')"
    description = "Local file inclusion rule"
  }

  # Remote file inclusion rule
  owasp_rule_rfi = {
    action      = "deny(403)"
    priority    = "1003"
    preview     = false
    expression  = "evaluatePreconfiguredExpr('rfi-v33-stable')"
    description = "Remote file inclusion rule sensitivity 2"
  }

  # Remote code execution rule
  owasp_rule_rce = {
    action      = "deny(403)"
    priority    = "1004"
    preview     = false
    expression  = "evaluatePreconfiguredExpr('rce-v33-stable',['owasp-crs-v030301-id932106-rce','owasp-crs-v030301-id932190-rce'])"
    description = "Remote code execution rule"
  }

  # Method enforcement rule
  owasp_rule_methodenf = {
    action      = "deny(403)"
    priority    = "1005"
    preview     = false
    expression  = "evaluatePreconfiguredExpr('methodenforcement-v33-stable')"
    description = "Method enforcement rule"
  }

  # Scan detection rule
  owasp_rule_scandetection = {
    action      = "deny(403)"
    priority    = "1006"
    preview     = false
    expression  = "evaluatePreconfiguredExpr('scannerdetection-v33-stable')"
    description = "Scan detection rule sensitivity 2"
  }

  # Protocol attack rule
  owasp_rule_protoattack = {
    action      = "deny(403)"
    priority    = "1007"
    preview     = false
    expression  = "evaluatePreconfiguredExpr('protocolattack-v33-stable',['owasp-crs-v030301-id921170-protocolattack'])"
    description = "Protocol attack rule sensitivity 2"
  }

  # PHP injection rule
  owasp_rule_phpinjection = {
    action      = "deny(403)"
    priority    = "1008"
    preview     = false
    expression  = "evaluatePreconfiguredExpr('php-v33-stable',['owasp-crs-v0303001-id933131-php','owasp-crs-v0303001-id933161-php','owasp-crs-v0303001-id933111-php','owasp-crs-v030301-id933190-php'])"
    description = "PHP injection rule sensitivity 2"
  }

  # Session fixation rule
  owasp_rule_sessionfixation = {
    action      = "deny(403)"
    priority    = "1009"
    preview     = false
    expression  = "evaluatePreconfiguredExpr('sessionfixation-v33-stable')"
    description = "Session fixation attack rule"
  }
}
