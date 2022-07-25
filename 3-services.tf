# Enable the Cloud Logging API
resource "google_project_service" "logging" {
    provider = google
    service  = "logging.googleapis.com"
    disable_on_destroy = false
}

# Enable the Cloud Storage API
resource "google_project_service" "storage" {
    provider = google
    service  = "storage.googleapis.com"
    disable_on_destroy = false
}

# Enable the Compute Engine API
resource "google_project_service" "compute" {
    provider = google
    service  = "compute.googleapis.com"
    disable_on_destroy = false
}

# Enable the Pub/Sub API
resource "google_project_service" "pubsub" {
    provider = google
    service  = "pubsub.googleapis.com"
    disable_on_destroy = false
}

# Enable the Cloud Functions API
resource "google_project_service" "cloudfunctions" {
    provider = google
    service  = "cloudfunctions.googleapis.com"
    disable_on_destroy = false
}

# Enable the Cloudbuild API
resource "google_project_service" "cloudbuild" {
    provider = google
    service  = "cloudbuild.googleapis.com"
    disable_on_destroy = false
}

# Enable the Cloud Scheduler API
resource "google_project_service" "cloudscheduler" {
    provider = google
    service  = "cloudscheduler.googleapis.com"
    disable_on_destroy = false
}

# Enable the Cloud Run API
resource "google_project_service" "run" {
    provider = google
    service  = "run.googleapis.com"
    disable_on_destroy = false
}