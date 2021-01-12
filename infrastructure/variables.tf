variable aws_region_name {
  type = string
  description = "The name of the AWS region to deploy infrastructure in."
  default = "us-east-2"
}

variable deployment_name {
  type = string
  description = "A value used to generate names of various resources. Should be as unique as possible."
}