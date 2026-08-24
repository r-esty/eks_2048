resource "aws_eks_cluster" "main" {
  name = var.cluster_name

  access_config {
    authentication_mode = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  role_arn = var.cluster_role_arn
  version  = "1.35"

  vpc_config {
    subnet_ids = var.subnet_ids
    security_group_ids = [aws_security_group.cluster.id]
  }
}

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = var.node_name
  node_role_arn   = var.cluster_node_arn
  subnet_ids      = var.private_subnet_ids

    instance_types = ["t3.medium"]
   capacity_type  = "ON_DEMAND"

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  launch_template {
    id = aws_launch_template.node.id
    version = aws_launch_template.node.latest_version
  }


}


resource "aws_security_group" "cluster" {
  name        = "cluster"
  description = "Allow cluster inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id
  

  tags = {
    Name = "allow_cluster"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_cluster_ipv4" {
  security_group_id = aws_security_group.cluster.id
  referenced_security_group_id = aws_security_group.node.id
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.cluster.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol       = "-1" 
}

resource "aws_security_group" "node" {
  name        = "node"
  description = "Allow node inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id
  

  tags = {
    Name = "allow_node"
  }
}

resource "aws_vpc_security_group_ingress_rule" "node_from_cluster" {
  security_group_id            = aws_security_group.node.id
  referenced_security_group_id = aws_security_group.cluster.id
  from_port                    = 10250
  to_port                      = 10250
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "allow_node_ipv4" {
  security_group_id = aws_security_group.node.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}


resource "aws_vpc_security_group_ingress_rule" "node_to_node" {
  security_group_id            = aws_security_group.node.id
  referenced_security_group_id = aws_security_group.node.id
  ip_protocol                  = "-1"
}

resource "aws_launch_template" "node" {
  name = "2048-launch-template"


  vpc_security_group_ids = [aws_security_group.node.id]



  
}
