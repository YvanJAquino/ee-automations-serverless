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