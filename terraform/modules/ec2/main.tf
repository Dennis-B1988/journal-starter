data "aws_ami" "amazon_linux" {
  count = var.ami == null ? 1 : 0

  most_recent = true
  owners      = var.ami_owners

  filter {
    name   = "name"
    values = [var.ami_name_filter]
  }
}

locals {
  ami_id = var.ami != null ? var.ami : data.aws_ami.amazon_linux[0].id
}

resource "aws_instance" "this" {
  count = var.instance_count

  ami                         = local.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_ids[count.index % length(var.subnet_ids)]
  vpc_security_group_ids      = var.vpc_security_group_ids
  associate_public_ip_address = var.associate_public_ip_address

  tags = merge(var.tags, {
    Name = "${var.name}-${count.index + 1}"
  })
}

resource "aws_eip" "this" {
  count = var.instance_count

  tags = merge(var.tags, {
    Name = "${var.name}-eip-${count.index + 1}"
  })
}

resource "aws_eip_association" "this" {
  count = var.instance_count

  instance_id   = aws_instance.this[count.index].id
  allocation_id = aws_eip.this[count.index].id
}