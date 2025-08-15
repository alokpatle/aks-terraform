module "eks" {
  source             = "terraform-aws-modules/eks/aws"
  version            = "21.0.9"
  name               = local.cluster_name
  kubernetes_version = var.kubernetes_version

  addons = {
    coredns = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy = {}
    vpc-cni = {
      before_compute = true
    }
  }
  enable_cluster_creator_admin_permissions = true
  enable_irsa = true

  tags = {
    cluster = "demo"
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    example = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.micro"]
      min_size       = 2
      max_size       = 3
      desired_size   = 2
    }
  }
}

