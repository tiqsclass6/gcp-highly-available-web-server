provider "google" {
  credentials = "<path/to/service-account.json>" # Insert your json credential here
  project     = "<PROJECT_ID_HERE>" #Insert your Project ID here
  region      = var.region
}