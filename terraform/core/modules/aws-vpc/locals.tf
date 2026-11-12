locals {
  tags = var.tags

  vpc_tags = merge(local.tags, {
    Name = var.name
  })

  internet_gateway_tags = merge(local.tags, {
    Name = "${var.name}-igw"
  })

  public_subnet_tags = {
    for az, _ in var.public_subnet_cidrs : az => merge(local.tags, {
      Name                     = "${var.name}-public-${az}"
      "kubernetes.io/role/elb" = "1"
    })
  }

  private_subnet_tags = {
    for az, _ in var.private_subnet_cidrs : az => merge(local.tags, {
      Name                              = "${var.name}-private-${az}"
      "kubernetes.io/role/internal-elb" = "1"
    })
  }

  public_route_table_tags = merge(local.tags, {
    Name = "${var.name}-public"
  })

  nat_gateway_tags = merge(local.tags, {
    Name = "${var.name}-nat"
  })

  private_route_table_tags = merge(local.tags, {
    Name = "${var.name}-private"
  })
}
