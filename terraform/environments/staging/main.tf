module "vpc" {
  source = "../../modules/vpc"

  name = var.name
  cidr = var.cidr

  tags = local.tags
}

module "subnet" {
  source = "../../modules/subnet"

  name = var.name

  vpc_id = module.vpc.vpc_id

  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  tags = local.tags
}

module "route_table" {
  source = "../../modules/route_table"

  name = var.name

  vpc_id = module.vpc.vpc_id
  igw_id = module.vpc.igw_id

  public_subnet_ids = module.subnet.public_subnet_ids

  tags = local.tags
}

module "api_security_group" {
  source = "../../modules/security_group"

  name        = "${var.name}-api-sg"
  description = "Security group for the ${var.name} API"
  vpc_id      = module.vpc.vpc_id

  ingress_rules = {
    http = {
      description = "HTTP from the world"
      port        = 80
      protocol    = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    }

    https = {
      description = "HTTPS from the world"
      port        = 443
      protocol    = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }

  egress_rules = {
    all = {
      description = "Allow all outbound traffic"
      protocol    = "-1"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }

  tags = local.tags
}

module "db_security_group" {
  source = "../../modules/security_group"

  name        = "${var.name}-db-sg"
  description = "Security group for the ${var.name} database"
  vpc_id      = module.vpc.vpc_id

  ingress_rules = {
    postgres = {
      description                  = "PostgreSQL from the API security group"
      port                         = 5432
      protocol                     = "tcp"
      referenced_security_group_id = module.api_security_group.security_group_id
    }
    eks = {
      description                  = "PostgreSQL from EKS worker nodes"
      port                         = 5432
      protocol                     = "tcp"
      referenced_security_group_id = module.eks_cluster_journal.cluster_security_group_id
    }
  }


  egress_rules = {
    all = {
      port      = 0
      protocol  = "-1"
      cidr_ipv4 = "0.0.0.0/0"
    }
  }

  tags = local.tags
}

module "api_ec2" {
  source = "../../modules/ec2"

  name = "${var.name}-api"

  instance_type  = var.instance_type
  instance_count = var.instance_count

  subnet_ids = module.subnet.public_subnet_ids

  vpc_security_group_ids = [
    module.api_security_group.security_group_id
  ]

  associate_public_ip_address = true

  tags = local.tags
}

module "api_db" {
  source = "../../modules/rds"

  identifier = "${var.name}-db"

  engine         = var.db_engine
  engine_version = var.db_engine_version
  instance_class = var.db_instance_class

  db_name  = "career_journal"
  username = var.db_username
  password = var.db_password

  allocated_storage       = var.db_allocated_storage
  backup_retention_period = var.db_backup_retention_period
  skip_final_snapshot     = var.db_skip_final_snapshot

  db_subnet_group_name = "${var.name}-db-subnet-group"
  subnet_ids           = module.subnet.private_subnet_ids

  vpc_security_group_ids = [
    module.db_security_group.security_group_id
  ]

  tags = local.tags
}

module "eks_cluster_journal" {
  source = "../../modules/eks"

  name       = "${var.name}-cluster"
  role_arn   = module.eks_cluster_role.role_arn
  subnet_ids = module.subnet.public_subnet_ids

  vpc_id = module.vpc.vpc_id

  tags = local.tags
}

module "eks_node_group_journal" {
  source = "../../modules/eks_node_group"

  name         = "${var.name}-node-group"
  cluster_name = module.eks_cluster_journal.name
  role_arn     = module.eks_node_role.role_arn

  subnet_ids = module.subnet.public_subnet_ids

  instance_types = ["t3.medium"]

  desired_size = 2
  min_size     = 1
  max_size     = 3

  tags = local.tags
}


module "eks_cluster_role" {
  source = "../../modules/iam_role"

  name        = "${var.name}-eks-cluster-role"
  description = "EKS Cluster Role"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "eks.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  ]

  tags = local.tags
}

# IAM Roles
module "eks_node_role" {
  source = "../../modules/iam_role"

  name        = "${var.name}-eks-node-role"
  description = "EKS Node Role"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ]

  tags = local.tags
}

module "journal_api_pod_role" {
  source = "../../modules/iam_role"

  name        = "${var.name}-pod-role"
  description = "IAM role for Journal API pods"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "pods.eks.amazonaws.com"
        }
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
      }
    ]
  })

  inline_policies = {
    journal_bedrock = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Action = [
            "bedrock-mantle:CreateInference"
          ]
          Resource = "*"
        }
      ]
    })
  }

  tags = local.tags
}

resource "aws_eks_addon" "pod_identity_agent" {
  cluster_name = module.eks_cluster_journal.name
  addon_name   = "eks-pod-identity-agent"

  tags = local.tags

  depends_on = [
    module.eks_node_group_journal
  ]
}

module "journal_api_pod_identity" {
  source = "../../modules/eks_pod_identity"

  name            = module.eks_cluster_journal.name
  namespace       = "default"
  service_account = "journal-api"

  role_arn = module.journal_api_pod_role.role_arn

  tags = local.tags

  depends_on = [
    aws_eks_addon.pod_identity_agent,
    module.journal_api_pod_role
  ]
}