# vpc.tf
#---------------------------------
# vpc 생성


resource "ncloud_vpc" "vpc01" {
    name = var.vpc01_name
    ipv4_cidr_block = var.vpc_cidr.0
}

#---------------------------------

### Network ACL 생성

resource "ncloud_network_acl" "network_acl_first_sub" {
  vpc_no = ncloud_vpc.vpc01.id
  name   = "${var.subnet_name["first_sub"]}-acl"
}

resource "ncloud_network_acl" "network_acl_second_sub" {
  vpc_no = ncloud_vpc.vpc01.id
  name   = "${var.subnet_name["second_sub"]}-acl"
}

resource "ncloud_network_acl" "network_acl_third_sub" {
  vpc_no = ncloud_vpc.vpc01.id
  name   = "${var.subnet_name["third_sub"]}-acl"
}


# Public Subnet 생성
resource "ncloud_subnet" "vpc01_pub_sub" {
  vpc_no = ncloud_vpc.vpc01.id
  name = "${var.subnet_name["first_sub"]}"
  subnet = cidrsubnet(ncloud_vpc.vpc01.ipv4_cidr_block, 8, 0)
  zone = var.zones.0
  network_acl_no = ncloud_network_acl.network_acl_first_sub.id
  subnet_type =  var.subnet_type.0
}


# Private Subnet 생성
resource "ncloud_subnet" "vpc01_pri_sub" {
  vpc_no = ncloud_vpc.vpc01.id
  name = "${var.subnet_name["second_sub"]}"
  subnet = cidrsubnet(ncloud_vpc.vpc01.ipv4_cidr_block, 8, 10)
  zone = var.zones.0
  network_acl_no = ncloud_network_acl.network_acl_second_sub.id
  subnet_type = var.subnet_type.1
  usage_type = var.subnet_usage.0
}
# LoadBalancer Subnet 생성
resource "ncloud_subnet" "vpc01_pri_lb_sub" {
  vpc_no = ncloud_vpc.vpc01.id
  name = "${var.subnet_name["third_sub"]}"
  subnet = cidrsubnet(ncloud_vpc.vpc01.ipv4_cidr_block, 8, 20)
  zone = var.zones.0
  network_acl_no = ncloud_network_acl.network_acl_third_sub.id
  subnet_type = var.subnet_type.1
  usage_type = var.subnet_usage.1
}


#--------------------------------------------------------------------------

### NAT Gateway 생성
resource "ncloud_nat_gateway" "nat_gateway" {
  vpc_no      = ncloud_vpc.vpc01.id
  zone        = var.zones.0
#  below fields is optional
  name        = "${var.vpc01_name}-ngw"
  description = "description"
}

resource "ncloud_route" "conn_nat_gateway" {
  route_table_no = ncloud_vpc.vpc01.default_private_route_table_no
  destination_cidr_block = "0.0.0.0/0"
  target_type = "NATGW"
  target_name = ncloud_nat_gateway.nat_gateway.name
  target_no = ncloud_nat_gateway.nat_gateway.id
}
