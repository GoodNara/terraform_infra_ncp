# Configure the ncloud provider
# provider.tf

provider "ncloud" {
  access_key  = var.access_key
  secret_key  = var.secret_key
  region      = var.region
  site        = var.sites.0
  support_vpc = var.support_vpc
}

#---------------------------------
# 확인 완료