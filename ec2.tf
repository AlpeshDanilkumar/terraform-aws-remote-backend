resource "aws_instance" "server1" {
  ami           = "ami-0b53285ea6c7a08a7"
  instance_type = "t2.micro"

  tags = {
    Name = "linux-server-2"
  }
}