project_id              = "terraform-in-gcp-429414"
credentials_file        = "credentials\\terraform-in-gcp-credential.json"
gcp_region              = "asia-northeast3"
gcp_zone                = "asia-northeast3-a"
subnet_ip_range         = "10.0.1.0/24"
vpc_auto_create_subnets = false
vpc_mtu                 = 1460
vm_config = {
  vm_name           = "flask-app-2"
  vm_type           = "e2-micro"
  vm_tags           = ["ssh", "flask", "web-app", "python-311"]
  vm_image          = "debian-cloud/debian-11"
  boot_disk_size    = 10
  vm_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python3-pip rsync; pip install flask"
}
