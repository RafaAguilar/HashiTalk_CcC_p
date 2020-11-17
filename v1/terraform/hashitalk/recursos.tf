module "mi-infra" {
  source   = "../modules/mi-infra"
  proyecto = "HashiTalk"

  cantidad_mvs = var.cantidad_mvs
  region       = var.region  
}