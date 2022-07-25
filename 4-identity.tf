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

# Update Project level IAM for the cloud BUild service account

# Enable Cloudbuild to deploy Cloud Functions
resource "google_project_iam_member" "cb_cloudfunctions_developer" {
  project = local.project
  role    = "roles/cloudfunctions.developer"
  member  = local.cloudbuild_service_account
}

# Enable Cloudbuild to deploy to Cloud Run
resource "google_project_iam_member" "cb_run_admin" {
  project = local.project
  role    = "roles/run.admin"
  member  = local.cloudbuild_service_account
}

# Enable Cloudbuild to use other Service Accounts
resource "google_project_iam_member" "cb_iam_sa_user" {
  project = local.project
  role    = "roles/iam.serviceAccountUser"
  member  = local.cloudbuild_service_account
}

# Enable Cloudbuild to read Secret versions
resource "google_project_iam_member" "cb_secrets_accessor" {
  project = local.project
  role    = "roles/secretmanager.secretAccessor"
  member  = local.cloudbuild_service_account
}