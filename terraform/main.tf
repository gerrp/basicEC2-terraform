resource "aws_vpc" "vpcTerraform" {
  cidr_block       = "172.16.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpcTerraform"
  }
}

resource "aws_subnet" "subnetTerraform" {
  vpc_id            = aws_vpc.vpcTerraform.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name = "subnetTerraform"
  }
}

resource "aws_internet_gateway" "gatewayTerraform" {
  vpc_id = aws_vpc.vpcTerraform.id

  tags = {
    Name = "gatewayTerraform"
  }
}


resource "aws_default_route_table" "routeTerraform" {
   default_route_table_id = aws_vpc.vpcTerraform.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gatewayTerraform.id
  }

  tags = {
    Name = "routeTerraform"
  }
}

resource "aws_route_table_association" "subnetRuteo" {
  subnet_id      = aws_subnet.subnetTerraform.id
  route_table_id = aws_default_route_table.routeTerraform.id
}



resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Permitir trafico SSH"
  vpc_id      = aws_vpc.vpcTerraform.id

  ingress {
    description      = "Puerto SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}


resource "tls_private_key" "llavePrivada" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "keypair" {
  key_name = "terraform-ssh-clave"
  public_key = tls_private_key.llavePrivada.public_key_openssh
}

resource "local_sensitive_file" "llave" {
  content  = tls_private_key.llavePrivada.private_key_openssh
  filename = "${path.module}/sshkey-${aws_key_pair.keypair.key_name}"
}


resource "aws_instance" "web" {
  ami           = "ami-0e83be366243f524a"
  instance_type = var.instance_type_test
  subnet_id     = aws_subnet.subnetTerraform.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name = aws_key_pair.keypair.key_name
  associate_public_ip_address = true

  root_block_device {
    volume_size = var.volume_size_test

  }

  tags = {
    Name = "PruebaTerraform"
  }
}