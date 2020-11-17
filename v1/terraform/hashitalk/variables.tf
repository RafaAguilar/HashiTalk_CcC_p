variable "region" {
  type = string
  description = "Región a desplegar el Proyecto"
  default = "us-central1"
}

variable "cantidad_mvs" {
  type = number
  description = "Cantidad de Máquinas Virtuales"
  default = 1
}