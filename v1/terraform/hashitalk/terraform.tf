terraform {
  backend "gcs" {
    bucket = "tf-state-mi-infra"
    prefix = "terraform/mi-infra.state"
  }
}