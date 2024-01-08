variable "aws_region" {
  default = "ap-south-1"
  type = string
  description = "AWS region to create AWS resource"
}

# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type = string
  default = "DevOps"
}
# Business Division
variable "business_divsion" {
  description = "Business Division in the large organization this Infrastructure belongs"
  type = string
  default = "Admin"
}