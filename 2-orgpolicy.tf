
# Allow Domain Restricted Sharing
resource "google_project_organization_policy" "domain_restricted_sharing" {
  constraint = "iam.allowedPolicyMemberDomains"
  project    = local.project

  list_policy {
    allow {
      all = true
    }
  }

}

# Allow Ingress settings for Cloud Functions
resource "google_project_organization_policy" "functions_allowed_ingress_settings" {
  constraint = "cloudfunctions.allowedIngressSettings"
  project    = local.project

  list_policy {
    allow {
      all = true
    }
  }

}

# Allow Ingress settings for Cloud Run
resource "google_project_organization_policy" "run_allowed_ingress_settings" {
  constraint = "run.allowedIngress"
  project    = local.project

  list_policy {
    allow {
      all = true
    }
  }

}