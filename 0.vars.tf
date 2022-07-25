# Project name
variable "name" {
    type = string
    default = "ee-automation"
}

# Project ID
variable "project_id" {
    type = string
    # Use the google_client_config    
    default = null
}

# Default region
variable "region" {
    type = string
    default = "us-central1"
}

# The developer who is deploying a Cloud Function and is a Earth Engine user.
variable "developer" {
    type = string
    default = "admin@yaquino.altostrat.com"
}