variable "myvar" {
  type = "string"
  default = "hello terraform"
}
variable "mymap" {
  type = map(string)
  default = {
    mykey = "my value"
  }
}