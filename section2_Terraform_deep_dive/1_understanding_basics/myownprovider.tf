terraform {
  required_providers {
    mycloud = {
      version = ">= 1.0.0"
      source = "mycorp/mycloud" # terraform's cloud registry (terraform-provider-mycloud)
    }
  }
  required_version = ">= 0.14"
}
