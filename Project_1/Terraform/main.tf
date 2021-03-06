provider "aws" {
region = "us-east-2"
shared_credentials_file = "~/.aws/credentials"
}

resource "aws_instance" "Master" {
  ami           = "${lookup(var.ami_id, var.region)}"
  instance_type = "t2.micro"
  key_name      = "winkp"
  vpc_security_group_ids=[aws_security_group.allow_ssh.id]
  subnet_id     = aws_subnet.sub.id
  
   provisioner "remote-exec" {
      inline = [
            "sudo apt-get update",
		    "sudo apt-get install -y tree unzip",
		    "sudo apt install -y  gnupg2 pass",
		    "sudo apt install -y openjdk-11-jre-headless",
        "sudo apt-get install -y maven",
            "sudo useradd -m -s /bin/bash jenkins; sudo echo 'jenkins:jenkins' | sudo  chpasswd",
		    "sudo echo jenkins | sudo -S -u jenkins mkdir -p /home/jenkins/jenkins",
            "sudo wget https://get.jenkins.io/war-stable/2.319.1/jenkins.war -P /home/jenkins/jenkins",
			"sudo echo jenkins | sudo -S -u jenkins  java -jar /home/jenkins/jenkins/jenkins.war &",
      ]
    }
	connection {
    user        = "ubuntu"
    private_key = "${file("${var.private_key_path}")}"
      host = "${aws_instance.Master.public_ip}"
  }
  tags = {
    Name = "VM1"
  }
  }
 resource "aws_instance" "Slave" {
  ami           = "${lookup(var.ami_id, var.region)}"
  instance_type = "t2.micro"
  key_name      = "winkp"
   vpc_security_group_ids=[aws_security_group.allow_ssh.id]
   subnet_id     = aws_subnet.sub.id
  
   provisioner "remote-exec" {
      inline = [
        "sudo apt-get update",
		    "sudo apt-get install -y tree unzip",
		    "sudo apt install -y  gnupg2 pass",
		    "sudo apt install -y openjdk-11-jre-headless",
		    "sudo apt-get install -y maven",
		    "sudo apt-get install software-properties-common",
            "sudo apt-get update",
		    "sudo apt-add-repository ppa:ansible/ansible -y",
		    "sudo apt-get update",
	    	"sudo apt-get install -y ansible",
		    "sudo apt-get install -y docker*",
			"sudo useradd -m -s /bin/bash jenkins; sudo echo 'jenkins:jenkins' | sudo  chpasswd",
			"sudo echo jenkins | sudo -S -u jenkins mkdir -p /home/jenkins/jenkins",
			"sudo usermod -aG docker jenkins",
            "sudo chmod 666 /var/run/docker.sock",
            "sudo usermod -G root jenkins",
		    "sudo curl 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip' -o 'awscliv2.zip'",
		    "sudo unzip awscliv2.zip",
            "sudo ./aws/install",
		    "sudo apt-get install -y git",
            "sudo apt-get install python-pip -y",
            "pip install -U boto",			
      ]
    }
  connection {
    user        = "ubuntu"
    private_key = "${file("${var.private_key_path}")}"
      host = "${aws_instance.Slave.public_ip}"
  }
  tags = {
    Name = "VM2"
  }
}
