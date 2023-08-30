resource "aws_instance" "ec2" {
  ami                     = data.aws_ami.ec2.id
  instance_type           = var.instance_type
  iam_instance_profile    = aws_iam_instance_profile.ec2.id
  subnet_id               = var.private_subnets
  vpc_security_group_ids = [ "${var.rds_sg}" ]

  user_data = <<EOF
#!/bin/bash
yum update -y
yum install -y git docker
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
rm get_helm.sh
git clone https://github.com/schrill/random_service_example.git
cd random_service_example/
./deploy.sh -c
EOF

  credit_specification {
    cpu_credits = "standard"
  }

  tags = {
    Terraform = "true"
    Name      = "${var.project_name}-bastion-${var.project_env}"
  }

}
