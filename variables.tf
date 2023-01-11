# variables.tf
#---------------------------------
# provider 설정

variable "access_key" {
  default = "O8JU2PmoRue9nIzrh05R"
}
# default = {"access_key"}
# 액세스 키 입력, "" 사용해야함


variable "secret_key" {
  default = "VQuxn9VxqUhfVBInL2ZYTFJL3sAZhMQ5YYAO3xGp"
}
# default = {"secret_key"}
# 시크릿 키 입력, "" 사용해야함

variable "region" {
  default = "KR"
}
# default = {"region"}
# 사용하려는 Region 입력

variable "zones" {
  type = list
  default = ["KR-1", "KR-2"]
}
# 사용하려는 zone count 입력
# ex. var.zones.0 or var.zones.1

variable "sites" {
  type = list
  default = ["public", "gov", "fin"]
}
# 사용하려는 site count 입력
# ex. var.sites.0 or var.sites.1 or var.sites.2

variable "support_vpc" {
  default = "true"
}
# true = vpc 환경 사용


#----------------------------------------------------------------------------
############### vpc 설정

variable "vpc01_name" {
  default = "cafe"
}
# VPC 이름 지정
# ex. default = {"VPC_NAME"}


variable "vpc_cidr" {
  type = list
  default = ["10.0.0.0/16", "172.16.0.0/16", "192.168.0.0/16"]
}
# 사용하려는 VPC 사설 대역대 count 입력
# ex. var.vpc_cidr.0 or var.vpc_cidr.1 or var.vpc_cidr.2


#----------------------------------------------------------------------------
############# Subnet 설정
variable "subnet_name" {
  type = map
  default = {
    "first_sub" = "latte-pub"
    "second_sub" = "cake-pri"
    "third_sub" = "juice-lb"
  }
}
# 사용하려는 서브넷 이름 지정 후 매핑 "key" = "value" 형식
# ex. name = "${var.subnet_name["first_sub"]}"
# ex. name = "${var.subnet_name["{key}"]}"


variable "subnet_type" {
  type = list
  default = ["PUBLIC", "PRIVATE"]
}
# 사용하려는 서브넷 타입 count 입력
# ex. var.subnet_type.0 or var.subnet_type.1


variable "subnet_usage" {
  type = list
  default = ["GEN", "LOADB"]
}
# 사용하려는 서브넷 용도 count 입력
# ex. var.subnet_usage.0 or var.subnet_usage.1


#-------------------------------------------------------------------------------------
### Server 변수

variable "server_name" {
  type = map
  default = {
   "server_1" = "chocolate"
   "server_2" = "name2"
   "server_3" = "name3"
  }
}
# 사용하려는 Server 이름 지정 후 매핑 "key" = "value" 형식
# ex. {"key"} = {"value"}


variable "server_count" {
  default = "1"
}
# Server 개수지정
# default = {"숫자"}
# ex. count = "${var.server_count}"


### Login Key 생성 (.pem)
variable "loginkey_name" {
  default = "chocolate"
}
# Login.key 이름 지정
# ex. default = {"KEY_NAME"}


######################################################################################
### Server Images 변수
### SERVER IMAGE PRODUCT CODE 

variable "svr_imgs" {
  type = map
  default = {
    "centos7.3" = "SW.VSVR.OS.LNX64.CNTOS.0703.B050"
    "centos7.8" = "SW.VSVR.OS.LNX64.CNTOS.0708.B050"
    "ubuntu18.04" = "SW.VSVR.OS.LNX64.UBNTU.SVR1804.B050"
    "ubuntu20.04" = "SW.VSVR.OS.LNX64.UBNTU.SVR2004.B050"
    "win2016" = "SW.VSVR.OS.WND64.WND.SVR2016EN.B100"
    "win2019" = "SW.VSVR.OS.WND64.WND.SVR2019EN.B100"
  }
}
# 사용하려는 이미지 이름 지정 후 매핑 "key" = "value" 형식
# ex. server_image_product_code = var.svr_imgs["centos7.8"]
# ex. server_image_product_code = var.svr_imgs["{key}"]


### Server Specs HDD 변수
### SERVER SPEC PRODUCT CODE HDD

variable "svr_specs_hdd" {
  type = map
  default = {
    "lnx.2.4" = "SVR.VSVR.HICPU.C002.M004.NET.HDD.B050.G002"
    "lnx.4.8" = "SVR.VSVR.HICPU.C004.M008.NET.HDD.B050.G002"
    "lnx.8.16" = "SVR.VSVR.HICPU.C008.M016.NET.HDD.B050.G002"
    "lnx.32.64" = "SVR.VSVR.HICPU.C032.M064.NET.HDD.B050.G002"
#----------------------------------------------------------------    
    "lnx.2.8" = "SVR.VSVR.STAND.C002.M008.NET.HDD.B050.G002"    
    "lnx.4.16" = "SVR.VSVR.STAND.C004.M016.NET.HDD.B050.G002"    
    "lnx.8.32" = "SVR.VSVR.STAND.C008.M032.NET.HDD.B050.G002"    
    "lnx.16.64" = "SVR.VSVR.STAND.C016.M064.NET.HDD.B050.G002"    
    "lnx.32.128" = "SVR.VSVR.STAND.C032.M128.NET.HDD.B050.G002"
#----------------------------------------------------------------    
    "lnx.2.16" = "SVR.VSVR.HIMEM.C002.M016.NET.HDD.B050.G002"    
    "lnx.4.32" = "SVR.VSVR.HIMEM.C004.M032.NET.HDD.B050.G002"    
    "lnx.8.64" = "SVR.VSVR.HIMEM.C008.M064.NET.HDD.B050.G002"    
    "lnx.32.256" = "SVR.VSVR.HIMEM.C032.M256.NET.HDD.B050.G002"            
#----------------------------------------------------------------    
    "win.2.4" = "SVR.VSVR.HICPU.C002.M004.NET.HDD.B100.G002"
    "win.4.8" = "SVR.VSVR.HICPU.C004.M008.NET.HDD.B100.G002"
    "win.8.16" = "SVR.VSVR.HICPU.C008.M016.NET.HDD.B100.G002"
    "win.16.32" = "SVR.VSVR.HICPU.C016.M032.NET.HDD.B100.G002"
    "win.32.64" = "SVR.VSVR.HICPU.C032.M064.NET.HDD.B100.G002"
#----------------------------------------------------------------    
    "win.2.8" = "SVR.VSVR.STAND.C002.M008.NET.HDD.B100.G002"    
    "win.4.16" = "SVR.VSVR.STAND.C004.M016.NET.HDD.B100.G002"    
    "win.8.32" = "SVR.VSVR.STAND.C008.M032.NET.HDD.B100.G002"    
    "win.16.64" = "SVR.VSVR.STAND.C016.M064.NET.HDD.B100.G002"    
    "win.32.128" = "SVR.VSVR.STAND.C032.M128.NET.HDD.B100.G002"
#----------------------------------------------------------------    
    "win.2.16" = "SVR.VSVR.HIMEM.C002.M016.NET.HDD.B100.G002"    
    "win.4.32" = "SVR.VSVR.HIMEM.C004.M032.NET.HDD.B100.G002"    
    "win.8.64" = "SVR.VSVR.HIMEM.C008.M064.NET.HDD.B100.G002"    
    "win.16.128" = "SVR.VSVR.HIMEM.C016.M128.NET.HDD.B100.G002"    
    "win.32.256" = "SVR.VSVR.HIMEM.C032.M256.NET.HDD.B100.G002"            
#---------------------------------------------------------------- 
  }
}
# 사용하려는 스펙 이름 지정 후 매핑 "key" = "value" 형식
# ex. server_product_code = var.svr_specs_hdd["lnx.2.4"]
# ex. server_product_code = var.{리소스_이름}["{key}"]


### Server Specs SSD 변수
### SERVER SPEC PRODUCT CODE SSD
variable "svr_specs_ssd" {
  type = map
  default = {
    "lnx.2.4" = "SVR.VSVR.HICPU.C002.M004.NET.SSD.B050.G002"
    "lnx.4.8" = "SVR.VSVR.HICPU.C004.M008.NET.SSD.B050.G002"
    "lnx.8.16" = "SVR.VSVR.HICPU.C008.M016.NET.SSD.B050.G002"
    "lnx.32.64" = "SVR.VSVR.HICPU.C032.M064.NET.SSD.B050.G002"
#----------------------------------------------------------------    
    "lnx.2.8" = "SVR.VSVR.STAND.C002.M008.NET.SSD.B050.G002"    
    "lnx.4.16" = "SVR.VSVR.STAND.C004.M016.NET.SSD.B050.G002"    
    "lnx.8.32" = "SVR.VSVR.STAND.C008.M032.NET.SSD.B050.G002"    
    "lnx.16.64" = "SVR.VSVR.STAND.C016.M064.NET.SSD.B050.G002"    
    "lnx.32.128" = "SVR.VSVR.STAND.C032.M128.NET.SSD.B050.G002"
#----------------------------------------------------------------    
    "lnx.2.16" = "SVR.VSVR.HIMEM.C002.M016.NET.SSD.B050.G002"    
    "lnx.4.32" = "SVR.VSVR.HIMEM.C004.M032.NET.SSD.B050.G002"    
    "lnx.8.64" = "SVR.VSVR.HIMEM.C008.M064.NET.SSD.B050.G002"    
    "lnx.32.256" = "SVR.VSVR.HIMEM.C032.M256.NET.SSD.B050.G002"            
#----------------------------------------------------------------    
    "win.2.4" = "SVR.VSVR.HICPU.C002.M004.NET.SSD.B100.G002"
    "win.4.8" = "SVR.VSVR.HICPU.C004.M008.NET.SSD.B100.G002"
    "win.8.16" = "SVR.VSVR.HICPU.C008.M016.NET.SSD.B100.G002"
    "win.16.32" = "SVR.VSVR.HICPU.C016.M032.NET.SSD.B100.G002"
    "win.32.64" = "SVR.VSVR.HICPU.C032.M064.NET.SSD.B100.G002"
#----------------------------------------------------------------    
    "win.2.8" = "SVR.VSVR.STAND.C002.M008.NET.SSD.B100.G002"    
    "win.4.16" = "SVR.VSVR.STAND.C004.M016.NET.SSD.B100.G002"    
    "win.8.32" = "SVR.VSVR.STAND.C008.M032.NET.SSD.B100.G002"    
    "win.16.64" = "SVR.VSVR.STAND.C016.M064.NET.SSD.B100.G002"    
    "win.32.128" = "SVR.VSVR.STAND.C032.M128.NET.SSD.B100.G002"
#----------------------------------------------------------------    
    "win.2.16" = "SVR.VSVR.HIMEM.C002.M016.NET.SSD.B100.G002"    
    "win.4.32" = "SVR.VSVR.HIMEM.C004.M032.NET.SSD.B100.G002"    
    "win.8.64" = "SVR.VSVR.HIMEM.C008.M064.NET.SSD.B100.G002"    
    "win.16.128" = "SVR.VSVR.HIMEM.C016.M128.NET.SSD.B100.G002"    
    "win.32.256" = "SVR.VSVR.HIMEM.C032.M256.NET.SSD.B100.G002"            
#---------------------------------------------------------------- 
  }
}
# 사용하려는 스펙 이름 지정 후 매핑 "key" = "value" 형식
# ex. server_product_code = var.svr_specs_ssd["lnx.2.4"]
# ex. server_product_code = var.{리소스_이름}["{key}"]
