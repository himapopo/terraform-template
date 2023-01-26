resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
}

# サブネット
resource "aws_subnet" "subnet_1a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_1a_cidr_block
  availability_zone = "ap-northeast-1a"
}

resource "aws_subnet" "subnet_1c" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_1c_cidr_block
  availability_zone = "ap-northeast-1c"
}

# インターネットゲートウェイ
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id
}

# ルートテーブル
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }
}

# ルートテーブルをサブネットに関連付け
resource "aws_route_table_association" "association1a" {
  subnet_id      = aws_subnet.subnet_1a.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "association1c" {
  subnet_id      = aws_subnet.subnet_1c.id
  route_table_id = aws_route_table.rt.id
}


output "vpc" {
  value = aws_vpc.vpc
}

output "subnet_1a" {
  value = aws_subnet.subnet_1a
}

output "subnet_1c" {
  value = aws_subnet.subnet_1c
}
