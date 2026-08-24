module vpc {
    source = "./vpc"

    cidr_block = "10.0.0.0/16"
    public_1_cidr_block = "10.0.1.0/24"
    public_2_cidr_block = "10.0.2.0/24"
    private_1_cidr_block = "10.0.3.0/24"
    private_2_cidr_block = "10.0.4.0/24"
    availability_zone_1 = "eu-west-2a"
    availability_zone_2 = "eu-west-2b"

}

module "iam" {
    source = "./iam"
    cluster_role_name = "eks-2048-cluster-role"
    node_role_name = "eks-2048-node-role"
    
}

module "eks" {
    source = "./eks"
    cluster_name = "eks-2048-cluster"
    cluster_role_arn = module.iam.cluster_role_arn
    vpc_id = module.vpc.id

      subnet_ids = [
    module.vpc.public_1_id,
    module.vpc.public_2_id,
    module.vpc.private_1_id,
    module.vpc.private_2_id,

  ]
  cluster_node_arn = module.iam.node_role_arn
  node_name = "eks-2048-node"


      private_subnet_ids = [
    module.vpc.private_1_id,
    module.vpc.private_2_id,
  ]

  
}


