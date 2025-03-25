

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
  count                  = var.instance_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = "gp3"
    delete_on_termination = true
  }

  ebs_optimized = true
  monitoring    = true

  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.instance_name}-${count.index}"
    # Environment = var.environment
  }
}

resource "aws_ebs_volume" "ec2_ebs" {
  count             = var.instance_count
  availability_zone = aws_instance.ec2_instance[count.index].availability_zone
  size              = var.ebs_size

  tags = {
    Name = "${var.instance_name}-${count.index}-EBS"
  }
}

resource "aws_volume_attachment" "ebs_attach" {
  count       = var.instance_count
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.ec2_ebs[count.index].id
  instance_id = aws_instance.ec2_instance[count.index].id
}
