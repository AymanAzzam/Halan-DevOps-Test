provider "aws"{
    region = "us-east-2"
    access_key = var.access_key
    secret_key = var.secret_key
}

resource "random_string" "rand" {
    length = 8
    special = false
    upper = false
}

resource "aws_instance" "API" {
    ami = "ami-0634c0a28904f5af6"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.API_sg.id]
    key_name = var.key_name

    provisioner "file" {
        source      = "scripts/install_postgres.sh"
        destination = "/tmp/install_postgres.sh"
    }

    provisioner "file" {
        source      = "scripts/install_docker.sh"
        destination = "/tmp/install_docker.sh"
    }

    provisioner "remote-exec" {
        
        connection {
            type = "ssh"
            host = self.public_ip
            user = "ubuntu"
            private_key = file("${path.module}/halan.pem")
        }

        inline = [
            "chmod +x /tmp/install_postgres.sh",
            "/tmp/install_postgres.sh",
            "chmod +x /tmp/install_docker.sh",
            "/tmp/install_docker.sh",
            "PGPASSWORD=${var.db_password} psql -h ${aws_db_instance.Postgres-Master.endpoint} -U ${var.db_user} -d ${var.db_name} -c 'CREATE TABLE ips ( ip varchar(80));'",
            "docker pull aymanazzam/halantest:halan",
            "docker run -p ${var.public_port}:5000 aymanazzam/halantest:halan python app.py ${var.db_name} ${var.db_user} ${var.db_password} ${aws_db_instance.Postgres-Master.endpoint} &"
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

resource "aws_db_instance" "Postgres-Master" {
    identifier = "postgres-master-${random_string.rand.result}"
    name = "halan"
    engine = "postgres"
    engine_version = "12.5"
    instance_class = "db.t2.micro"
    allocated_storage = 20
    skip_final_snapshot  = true
    username = var.db_user
    password = var.db_password
}