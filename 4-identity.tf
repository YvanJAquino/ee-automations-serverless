# Create a service account for the application
resource "google_service_account" "service" {
  account_id   = "ee-automations-serverless"
  display_name = "Earth Engine Serverless Automation"
}

# Grant the service account roles
resource "google_project_iam_member" "cloudfunctions_admin" {
  project = local.project
  role    = "roles/cloudfunctions.admin"
  member  = "serviceAccount:${google_service_account.service.email}"
}

resource "google_project_iam_member" "run_admin" {
  project = local.project
  role    = "roles/run.admin"
  member  = "serviceAccount:${google_service_account.service.email}"
}

resource "google_project_iam_member" "cloudscheduler_admin" {
  project = local.project
  role    = "roles/cloudscheduler.admin"
  member  = "serviceAccount:${google_service_account.service.email}"
}

resource "google_project_iam_member" "earthengine_admin" {
  project = local.project
  role    = "roles/earthengine.admin"
  member  = "serviceAccount:${google_service_account.service.email}"
}

data "google_service_account" "cloudbuild" {
    account_id = "${local.project_number}@cloudbuild.gserviceaccount.com"
}

output "cloudbuild_sa_test" {
    value = data.google_service_account.cloudbuild.email
}

output "cloudbuild_sa_test2" {
    value = data.google_service_account.cloudbuild.unique_id
}