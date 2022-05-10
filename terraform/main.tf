module "ecr-go" {
  source = "./modules/ecr"
  name   = "go"
}

module "vpc" {
  source = "./modules/network"
  name   = "lab"
}

module "eks" {
  source    = "./modules/eks"
  name      = "lab"
  subnet_id = [module.vpc.private_id, module.vpc.public_id]
  subnet_priv_id = [module.vpc.public_id]
  sg = module.vpc.sg_id
  depends_on = [
      module.vpc
  ]
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "sergey-lab-bucket"
  acl    = "public-read-write"

  versioning = {
    enabled = true
  }

}