resource "google_project_iam_policy" "proj_infra_iam_test_0_iam_policy" {
  project     = "proj-infra-iam-test-0"
  policy_data = data.google_iam_policy.proj_infra_iam_test_0_policy.policy_data
}
