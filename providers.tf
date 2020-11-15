terraform {
  required_version = ">= 0.13"
  required_providers {
    unifi = {
      source  = "paultyng/unifi"
      version = "0.18.0"
    }
  }
}