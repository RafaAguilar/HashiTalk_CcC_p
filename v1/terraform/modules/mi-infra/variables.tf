variable "proyecto" {
  type = string
  description = "Nombre del Proyecto"
}

variable "region" {
  type = string
  description = "Región a desplegar el Proyecto"
  default = "us-central1"
}

variable "proposito" {
  type = string
  description = "Proposito de existencia para el recurso"
  default = "demo"
}

variable "cantidad_mvs" {
  type = number
  description = "Cantidad de Máquinas Virtuales"
  default = 1
}