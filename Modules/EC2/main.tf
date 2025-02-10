# --- SECURITY GROUP ---
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-security-group"
  description = "Allow SSH and HTTP"
  vpc_id      = var.vpc_id # Ensure security group is attached to the correct VPC

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH (change this for security)
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP traffic
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }
}


resource "aws_instance" "ec2_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id                  # Assign instance to the subnet
  vpc_security_group_ids = [aws_security_group.ec2_sg.id] # Attach the SG to instance

  tags = {
    Name = var.instance_name
  }
}


resource "aws_ebs_volume" "ec2_ebs" {
  availability_zone = aws_instance.ec2_instance.availability_zone
  size              = var.ebs_size

  tags = {
    Name = "${var.instance_name}-EBS"
  }
}

resource "aws_volume_attachment" "ebs_attach" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.ec2_ebs.id
  instance_id = aws_instance.ec2_instance.id
}