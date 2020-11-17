provider "google" {
  project     = "modified-ripsaw-295523"
  credentials = file("/tmp/modified-ripsaw-295523-d4c510d668b6.json")
  region      = var.region
}