resource "aws_instance" "Wireless" {
  ami           = "ami-0817d428a6fb68645"
  instance_type = "t2.micro"
  key_name      = "charles"
  vpc_security_group_ids = [aws_security_group.Wireless.id,
  ]
  subnet_id = aws_subnet.Wireless-private-subnet.id
  tags = {
    Name = "terraform-Wireless-instance"
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("/home/charly/charles.pem")
    host        = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y ca-certificates wget",
      "wget https://get.glennr.nl/unifi/install/unifi-5.13.32.sh",
    ]
    on_failure = continue
  }
}