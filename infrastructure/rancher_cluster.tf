module k3s_rancher {
  source = "git::https://github.com/yardbirdsax/terraform-k3s-on-ec2//terraform?ref=1.3"
  providers = {
    aws = aws
    random = random
  }

  assign_public_ip = true
  deployment_name = var.deployment_name
  instance_type = "t3a.small"
  keypair_content = module.ssh_key_pair.public_key
  security_group_ids = [ aws_security_group.rancher.id, aws_security_group.k8s.id ]
  subnet_id = module.vpc.public_subnets[0]
  worker_node_desired_count = 0
  kubeconfig_mode = 644
  
}

output rancher_k3s_dns {
  value = module.k3s_rancher.instance.public_dns
}