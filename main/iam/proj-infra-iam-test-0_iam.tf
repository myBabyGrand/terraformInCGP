data "google_iam_policy" "proj_infra_iam_test_0_policy" {
  binding {
    role = "roles/owner"
    members = [
      "user:gcp-admin@mybabygrand.kr",
      "user:sa-core@mybabygrand.kr",
      "serviceAccount:sa-terraform-in-gcp-core@terraform-in-gcp-core-430313.iam.gserviceaccount.com"
    ]
  }

  binding {
    role = "roles/editor"
    members = [
      "serviceAccount:14900559749@cloudservices.gserviceaccount.com",
      "user:second_user@mybabygrand.kr",
    ]
  }
}
