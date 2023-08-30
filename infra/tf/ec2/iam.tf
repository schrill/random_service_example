resource "aws_iam_role" "ec2" {
  name       = "${var.project_name}-ec2-${var.project_env}"
  description = "AWS IAM assume role policy used for EC2 instances"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "ec2" {
  name = "${var.project_name}-bastion-${var.project_env}"
  role = aws_iam_role.ec2.name
}

resource "aws_iam_role_policy_attachment" "ec2" {
  role       = aws_iam_role.ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
