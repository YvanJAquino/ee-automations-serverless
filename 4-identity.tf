# Create a service account for the application
resource "google_service_account" "service" {
  account_id   = "ee-automations-serverless"
  display_name = "Earth Engine Serverless Automation"
}

# Grant the application service account roles
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

# Update IAM for the Cloudbuild service account

# Enable Cloudbuild to deploy Cloud Functions
resource "google_project_iam_member" "cb_cloudfunctions_developer" {
  project = local.project
  role    = "roles/cloudfunctions.developer"
  member  = local.cb_sa_member
}

# Enable Cloudbuild to deploy to Cloud Run
resource "google_project_iam_member" "cb_run_admin" {
  project = local.project
  role    = "roles/run.admin"
  member  = local.cb_sa_member
}

# Enable Cloudbuild to use other Service Accounts
resource "google_project_iam_member" "cb_iam_sa_user" {
  project = local.project
  role    = "roles/iam.serviceAccountUser"
  member  = local.cb_sa_member
}

# Enable Cloudbuild to read Secret versions
resource "google_project_iam_member" "cb_secrets_accessor" {
  project = local.project
  role    = "roles/secretmanager.secretAccessor"
  member  = local.cb_sa_member
}

# Grant the default service account membership to the application service account
# This is provided to enable service account impersonation for testing purposes.

data "google_compute_default_service_account" "default" {
}

resource "google_service_account_iam_member" "dev_on_app_sa_user" {
  service_account_id = google_service_account.service.name
  role               = "roles/iam.serviceAccountUser"
  member             = "user:${var.developer}"
}

resource "google_service_account_iam_member" "dev_on_app_sa_token_creator" {
  service_account_id = google_service_account.service.name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "user:${var.developer}"
}

# Grant Application SA as a user to Default
resource "google_service_account_iam_member" "app_sa_on_default_user" {
  service_account_id = data.google_compute_default_service_account.default.name
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${google_service_account.service.email}"
}

resource "google_service_account_iam_member" "app_sa_on_default_token_creator" {
  service_account_id = google_service_account.service.name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:${google_service_account.service.email}"
}

# Grant Default as a user to Application SA
resource "google_service_account_iam_member" "app_sa_on_default_user" {
  service_account_id = "serviceAccount:${google_service_account.service.email}"
  role               = "roles/iam.serviceAccountUser"
  member             = data.google_compute_default_service_account.default.name
}

resource "google_service_account_iam_member" "app_sa_on_default_token_creator" {
  service_account_id = "serviceAccount:${google_service_account.service.email}"
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = google_service_account.service.name 
}