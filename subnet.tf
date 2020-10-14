resource "aws_subnet" "dev" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/18"
  availability_zone = "us-east-1a"

  tags = {
    Name = "tf-example"
  }
}
