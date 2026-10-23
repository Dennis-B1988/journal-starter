resource "aws_route_table" "this" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.cidr
    gateway_id = var.igw_id
  }

  tags = merge(var.tags, {
    Name = "${var.name}-rt"
  })
}

resource "aws_route_table_association" "this" {
  count = length(var.public_subnet_ids)

  subnet_id      = var.public_subnet_ids[count.index]
  route_table_id = aws_route_table.this.id
}