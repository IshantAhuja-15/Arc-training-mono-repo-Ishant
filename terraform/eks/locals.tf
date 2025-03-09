locals {
  subnet_suffixes = {
    "us-east-1" = ["use1a", "use1b"]
  }
}

locals {
  suffixes = lookup(local.subnet_suffixes, var.region, ["use1a", "use1b"])
}
