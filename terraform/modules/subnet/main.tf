resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id            = var.vpc_id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = var.azs[count.index]

  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "${var.name}-public-${count.index + 1}"
  })

  lifecycle {
    precondition {
      condition     = length(var.azs) >= length(var.public_subnets)
      error_message = "Not enough availability zones provided for the public subnets."
    }
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.azs[count.index]

  map_public_ip_on_launch = false

  tags = merge(var.tags, {
    Name = "${var.name}-private-${count.index + 1}"
  })

  lifecycle {
    precondition {
      condition     = length(var.azs) >= length(var.private_subnets)
      error_message = "Not enough availability zones provided for the private subnets."
    }
  }
}