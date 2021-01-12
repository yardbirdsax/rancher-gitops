data "http" "local_ip_address" {
  url = "https://ipv4.icanhazip.com/"
}

resource "aws_security_group" "k8s" {
  name = "k8s"
  vpc_id = module.vpc.vpc_id
  tags = {
    "deployment" = var.deployment_name
  }
}

resource "aws_security_group_rule" "k8s_https" {
 security_group_id = aws_security_group.k8s.id
 type = "ingress"
 from_port = 6443
 to_port = 6443
 protocol = "tcp"
 self = true
}

resource "aws_security_group_rule" "all_from_local" {
 security_group_id = aws_security_group.k8s.id
 type = "ingress"
 from_port = 0
 to_port = 0
 protocol = "-1"
 cidr_blocks = [ "${chomp(data.http.local_ip_address.body)}/32" ]
}

resource "aws_security_group_rule" "k8s_allow_all_out" {
  security_group_id = aws_security_group.k8s.id
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group" "rancher" {
  name = "rancher"
  vpc_id = module.vpc.vpc_id
  tags = {
    "deployment" = var.deployment_name
  }
}

resource "aws_security_group_rule" "rancher_https" {
  security_group_id = aws_security_group.rancher.id
  type = "ingress"
  from_port = 443
  to_port = 443
  cidr_blocks = [ "0.0.0.0/0" ]
  protocol = "tcp"
}