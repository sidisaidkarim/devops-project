module "network" {
  source = "./modules/network"
  vpc_a_name = var.vpc_a_name
  vpc_a_cidr = var.vpc_a_cidr
  vpc_b_name = var.vpc_b_name
  vpc_b_cidr = var.vpc_b_cidr
  subnet_az = var.availability_zone
}

module "security_group" {
  source = "./modules/security_group"
  vpc_a_id = module.network.vpc_a_id
}

module "ec2" {
  source = "./modules/ec2"
  sg_id = module.security_group.sg_id
  subnet_id = module.network.subnetsA[0].id
}

output "instance_ec2_public_ip" {
  description = "The public IP address of the EC2 instance"
  value = module.ec2.ec2_public_ip
}
