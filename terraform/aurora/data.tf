################################################
## imports
################################################
## vpc
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["ishant-dev-vpc"]
  }
}


data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
  filter {
    name = "tag:Name"
    values = [
      "ishant-dev-private-subnet-private-use1a",
      "ishant-dev-private-subnet-private-use1b"
    ]
  }
}
