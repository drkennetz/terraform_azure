variable "location" {
  type = string
  default = "centralus"
}

variable "prefix" {
  type = string
  default = "demo"
}

variable "ssh-source-address" {
  type = string
  default = "*"
}
