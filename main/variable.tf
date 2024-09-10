variable "project_id" {
  type        = string
  description = "The project ID that I will be working with"
}

variable "credentials_file" {
  type        = string
  description = "The JSON credential file to be used within the provider.tf file"
}

variable "gcp_region" {
  type        = string
  description = "The primary GCP region to deploy the resources"
  default     = "asia-northeast3"
}

variable "gcp_zone" {
  type        = string
  description = "The primary GCP zone within the region to be used"
  default     = "asia-northeast3-a"
}

variable "organization_id" {
  type = string
}

variable "billing_account" {
  type = string
}

variable "proj_net_hub_prod_0_services" {
  type        = list(string)
  description = "the list of the services that we want to eable in the GCP project"
}

variable "proj_infra_bapp1_prod_0_services" {
  type        = list(string)
  description = "the list of the services that we want to eable in the GCP project"
}


# VPC
variable "subnet_ip_range" {
  type        = list(string)
  description = "The list of IPv4 CIDR ranges to be used in the VPC that will be created"
}

variable "vpc_auto_create_subnets" {
  type        = bool
  description = "Defines the behavior for the VPC whether we want to use it in auto mode (true) or a custom VPC (false)"
  default     = false
}

variable "vpc_mtu" {
  type        = number
  description = "The value of the MTU for our new VPC"
  default     = 1460
}

# VMs
variable "business_app_1_app_vm_config" {
  description = "The app VM configuration values and properties"
  type = object(
    {
      app_name                = string
      short_app_name          = string
      vm_name                 = string
      vm_type                 = string
      vm_tags                 = list(string)
      vm_image                = string
      vm_boot_disk_type       = string
      boot_disk_size          = number
      vm_startup_script       = string
      autoscaler_min_replicas = number
      autoscaler_max_replicas = number
    }
  )
}

variable "business_app_1_db_vm_config" {
  description = "The DB VM configuration values and properties"
  type = object(
    {
      app_name          = string
      short_app_name    = string
      vm_name           = string
      vm_type           = string
      vm_tags           = list(string)
      vm_image          = string
      vm_boot_disk_type = string
      boot_disk_size    = number
      vm_startup_script = string
    }
  )
}

variable "named_ports" {
  type = object({
    bapp1 = object({
      port_name   = string
      port_number = number
    })
  })
}
