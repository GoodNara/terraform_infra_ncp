# server.tf
#---------------------------------
# ACG, Login Key, Server, Public IP 

### Access Control Group(ACG) 생성
resource "ncloud_access_control_group" "acg" {
  count = "${var.server_count}"
  name        = "${var.server_name["server_1"]}-acg${count.index+1}"
  description = "description"
  vpc_no      = ncloud_vpc.vpc01.id
}

### Access Control Group(ACG) 정책 설정
resource "ncloud_access_control_group_rule" "acg-rule" {
  count = "${var.server_count}"
  access_control_group_no = ncloud_access_control_group.acg[count.index].id
  inbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0"
    port_range  = "22"
    description = "accept 22 port-SSH"
  }
}


### Login Key 생성 (.pem)
resource "ncloud_login_key" "loginkey" {
  key_name = var.loginkey_name
}

resource "local_file" "ssh_key" {
  filename = "${ncloud_login_key.loginkey.key_name}.pem"
  content = ncloud_login_key.loginkey.private_key
}


#---------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------
resource "ncloud_network_interface" "nic_bastion" {
  count = "${var.server_count}"
  name                  = "${var.vpc01_name}-bastion-nic"
  subnet_no             = ncloud_subnet.vpc01_pub_sub.id
  access_control_groups = [ncloud_access_control_group.acg[count.index].id]
  /*Attributes Reference
    ncloud_network_interface.nic_bastion.id
  */
}


#Init script(optional)
resource "ncloud_init_script" "init_script_change_password" {
  name    = "change-password"
  content = "#!/bin/bash\n echo 'qwe1212!Q' | passwd --stdin root"
}


### Server 생성
resource "ncloud_server" "server_pub" {
  count = "${var.server_count}"
  subnet_no                 = ncloud_subnet.vpc01_pub_sub.id
  name        = "${var.server_name["server_1"]}-bastion${count.index+1}"
  description = "description"
  is_protect_server_termination = "false"
  server_image_product_code = var.svr_imgs["centos7.8"]
  server_product_code = var.svr_specs_hdd["lnx.2.4"]
  login_key_name            = ncloud_login_key.loginkey.key_name
  init_script_no            = ncloud_init_script.init_script_change_password.id
  network_interface   {
    network_interface_no = ncloud_network_interface.nic_bastion[count.index].id
    order = 0
  }
}


# Public IP
resource "ncloud_public_ip" "public_ip" {
  count = "${var.server_count}"
  server_instance_no = ncloud_server.server_pub[count.index].id
  description        = "description"
}

