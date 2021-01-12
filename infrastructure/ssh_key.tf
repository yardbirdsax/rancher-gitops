module "ssh_key_pair" {
  source                = "git::https://github.com/cloudposse/terraform-aws-key-pair.git?ref=master"
  namespace             = var.deployment_name
  stage                 = "prod"
  name                  = var.deployment_name
  ssh_public_key_path   = pathexpand("~/.ssh")
  generate_ssh_key      = "true"
  private_key_extension = ".pem"
  public_key_extension  = ".pub"
}