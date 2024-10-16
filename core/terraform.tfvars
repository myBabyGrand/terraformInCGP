project_id       = "terraform-in-gcp-core-430313"
credentials_file = "..\\credentials\\mybabygrand-terraform-in-gcp-core.json"
gcp_region       = "asia-northeast3"
gcp_zone         = "asia-northeast3-a"

core_tf_project_services = [
  "cloudbilling.googleapis.com",
  "billingbudgets.googleapis.com",
  "sqladmin.googleapis.com",
  "servicenetworking.googleapis.com",
]
