# SPDX-FileCopyrightText: 2023 Unidealistic Raccoon <procyon@secureninja.maskmy.id>
#
# SPDX-License-Identifier: MIT

# Network

resource "random_pet" "vcn_dns_label" {
  length = 1
}

module "vcn" {
  source                   = "oracle-terraform-modules/vcn/oci"
  create_nat_gateway       = true
  create_service_gateway   = true
  create_internet_gateway  = true
  lockdown_default_seclist = true
  vcn_name                 = "Default VCN"
  vcn_cidrs                = ["${var.vcn_cidr}"]
  vcn_dns_label            = random_pet.vcn_dns_label.id
  compartment_id           = data.sops_file.oci.data["tenancy_ocid"]
}

resource "random_pet" "subnet_public_dns_label" {
  length = 1
}

resource "oci_core_subnet" "public" {
  display_name      = "Public Subnet"
  vcn_id            = module.vcn.vcn_id
  route_table_id    = module.vcn.ig_route_id
  security_list_ids = [module.vcn.default_security_list_id]
  dns_label         = random_pet.subnet_public_dns_label.id
  compartment_id    = data.sops_file.oci.data["tenancy_ocid"]
  cidr_block        = cidrsubnet(var.vcn_cidr, var.newbits["public"], var.netnum["public"])
}

resource "random_pet" "subnet_private_dns_label" {
  length = 1
}

resource "oci_core_subnet" "private" {
  display_name      = "Private Subnet"
  vcn_id            = module.vcn.vcn_id
  route_table_id    = module.vcn.nat_route_id
  security_list_ids = [module.vcn.default_security_list_id]
  dns_label         = random_pet.subnet_private_dns_label.id
  compartment_id    = data.sops_file.oci.data["tenancy_ocid"]
  cidr_block        = cidrsubnet(var.vcn_cidr, var.newbits["private"], var.netnum["private"])
}

resource "random_pet" "main_bastion" {
  length = 1
}

resource "oci_bastion_bastion" "main" {
  bastion_type                 = "STANDARD"
  client_cidr_block_allow_list = ["0.0.0.0/0"]
  target_subnet_id             = oci_core_subnet.private.id
  name                         = random_pet.main_bastion.id
  compartment_id               = data.sops_file.oci.data["tenancy_ocid"]
}
