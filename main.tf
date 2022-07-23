provider "aws" {
    region = var.AWS_REGION
    access_key = var.AWS_ACCESS_KEY
    secret_key = var.AWS_SECRET_KEY
}

#Mise en place de security group pour se co en 80 
resource "aws_security_group" "instance_sg" {
    name = "terraform-test-sg"

    egress { #Permet de resortir pour la reponse
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    ingress { #Permet de la rendre accessible
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "my_ec2_instance" {
    # Definition de l'image 
    ami = "ami-002ff2c881c910aa8"

    # Type d'instance 
    instance_type = "t2.micro"

    # On lui attribut le groupe definit au dessus 
    vpc_security_group_ids = [aws_security_group.instance_sg.id]

    # Execution du code
	user_data = <<-EOF
		#!/bin/bash
        sudo apt-get update
		sudo apt-get install -y apache2
		sudo systemctl start apache2
		sudo systemctl enable apache2
		sudo echo "<h1>Salut Geoffrey</h1>" > /var/www/html/index.html
	EOF

    tags = {
        Name = "terraform test"
    }
}

#Permet de recuperer l'IP en sortie
output "public_ip" {
    value = aws_instance.my_ec2_instance.public_ip
}