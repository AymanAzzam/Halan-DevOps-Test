provider "aws"{
    region = "us-east-2"
    access_key = var.access_key
    secret_key = var.secret_key
}

resource "aws_instance" "API" {
    ami = "ami-0634c0a28904f5af6"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.API_sg.id]
    key_name = var.key_name

    provisioner "remote-exec" {
        
        connection {
            type = "ssh"
            host = self.public_ip
            user = "ubuntu"
            private_key = file("${path.module}/halan.pem")
        }

        inline = [
            "sudo add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable'",
            "sudo apt-get update -y",
            "sudo apt-get install docker.io",
            "docker pull aymanazzam/halantest:halan",
            "docker run -p ${var.public_port}:5000 aymanazzam/halantest:halan python app.py ${var.db_name} ${var.db_user} ${var.db_password} ${var.db_host} &"
        ]
    }
}

resource "aws_security_group" "API_sg" {
    name = "halan-api-sg"
    ingress {
        from_port = var.public_port
        to_port = var.public_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }

}