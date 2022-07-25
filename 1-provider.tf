# Google Cloud Provider
provider "google"  {
    alias = "default"
}

# Attributes include: access_token, project, region, and zone
data "google_client_config" "default" {
    provider = google.default
}

locals {
    project = coalesce(var.project_id, data.google_client_config.default.project)
    region  = coalesce(var.region, data.google_client_config.default.region)
}

# Recreate the provider based on defaults or user-provided variables.
provider "google" {
    project = local.project
    region  = local.region
}

terraform {
  backend "gcs" {
    bucket = "nodal-spot-341618"
    prefix = "terraform"
  }
}