data "aws_ami" "ec2" {
 most_recent = true

 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }

 filter {
   name   = "name"
   values = ["amzn2-ami-kernel-*hvm*-gp2"]
 }

  owners = ["amazon"]
}
