provider "aws" {}

data "aws_availability_zones" "aws_zones" {

}

data "aws_caller_identity" "current" {
  
}

data "aws_region" "aws_region" {
  
}

output "output_aws_zones" {
    value = data.aws_availability_zones.aws_zones.names
    #sensitive   = false
    #description = "aws_zones"
    #depends_on  = []
}

output "caller" {
    value = data.aws_caller_identity.current.account_id
}

output "region" {
    value = data.aws_region.aws_region.name
}