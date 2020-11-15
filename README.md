# terraform-unifi-controller

Terraform module for managing Unifi Controller resources

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Latest Release](https://img.shields.io/github/v/release/rkoosaar/terraform-unifi-controller?cacheSeconds=36)](https://github.com/rkoosaar/terraform-unifi-controller/releases/latest)
[![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/rkoosaar/controller/unifi)

## Examples

```
locals {
  ufr_src_firewall_group_ids = flatten([[module.unifi-fw-addressgroup.ufg-id], [], [module.unifi-fw-portgroup.ufg-id]])
  ufr_src_network_id_format = element(module.unifi-net-vlan.un-id, 0)
}

module "unifi-fw-addressgroup" {
  source = "../modules/terraform-unifi-controller"
  ufg_enable  = true
  ufg_name    = "UFG-ADDRESS-GROUP-TEST"
  ufg_type    = "address-group"
  ufg_members = ["10.16.15.227", "10.16.15.228"]
}

module "unifi-fw-portgroup" {
  source = "../modules/terraform-unifi-controller"
  ufg_enable  = true
  ufg_name    = "UFG-PORT-GROUP-TEST"
  ufg_type    = "port-group"
  ufg_members = ["6007", "8006"]
}

module "unifi-fw-rule" {
  source = "../modules/terraform-unifi-controller"
  ufr_enable = true
  # Required
  ufr_name     = "UFR-RULE-TEST"
  ufr_action   = "drop"
  ufr_protocol = "tcp"
  ufr_rule_index = "2016"
  ufr_ruleset    = "LAN_IN" #type in GUI
  # Optional - Source
  ufr_src_firewall_group_ids = [] # use this if you want an any any rule
  # Optional - Destination
  ufr_dst_address = "10.16.80.227"
}

module "unifi-wlan-test" {
  source = "../modules/terraform-unifi-controller"
  
  # Create or not
  uw_enable = true

  # Required
  uw_name = "TEST-SSID"
  uw_security       = "wpapsk"
  uw_user_group_id    = data.unifi_user_group.default.id

  # Optional
  uw_ap_group_ids = [data.unifi_ap_group.default.id]
  uw_hide_ssid = true
  uw_is_guest = false
  uw_mac_filter_enabled = true
  uw_mac_filter_list = ["02:3D:40:19:E7:D5","22:E4:C7:B8:23:1E"]
  uw_mac_filter_policy = "allow"
  uw_multicast_enhance = true
  uw_network_id = local.ufr_src_network_id_format
  uw_passphrase = "testtest.11"
  #uw_radius_profile_id = ""  
  uw_schedule = {
      block_end = "11:01",
      block_start = "12:00",
      day_of_week = "sat",
    }
  #uw_site = "default"
}
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
| --- | --- |
| terraform | >= 0.13 |

## Providers

| Name | Version |
| --- | --- |
| unifi | >= 0.18.0 |

## Inputs

### unifi\_firewall\_group

| Name | Description | Type | Required |
| --- | --- | --- | --- |
| ufg_enable | Enables or Disables unifi firewall group creation. Defaults to false | `bool` | yes |
| ufg_name | The name of the firewall group | `string` | yes |
| ufg_type | The type of the firewall group. Must be one of: address-group, port-group, or ipv6-address-group | `string` | yes |
| ufg_members | The members of the firewall group | `list(string)` | yes |

### unifi\_firewall\_rule

| Name | Description | Type | Required |
| --- | --- | --- | --- |
| ufr_enable | Enables or Disables unifi firewall rule creation. Defaults to false | `bool` | yes |
| ufr_name | The name of the firewall rule | `string` | yes |
| ufr_action | The action of the firewall rule. Must be one of drop, accept, or reject | `string` | yes |
| ufr_protocol | The protocol of the rule. Must be one of all, tcp, udp, tcp and udp, icmp, ah, ax.25, dccp, ddp, egp, eigrip, encap, esp, etherip, fc, ggp, gre, hip, hmp, idpr-cmtp, idrp, igmp, igp, ip, ipcomp, ipencap, ipip, ipv6, ipv6-frag, ipv6-icmp, ipv6-nonxt, ipv6-opts, ipv6-route, is-is, iso-tp4, l2tp, manet, mobility header, mpls-in-ip, ospf, pim, pup, rdp, rohc, rspf, rsvp, sctp, shim6, skip, st, udplite, vmtp, vrrp, wesp, xns-dip, xtp, number | `string` | yes |
| ufr\_rule\_index | The index of the rule. Must be >= 2000 &lt; 3000 or &gt;= 4000 < 5000 | `number` | yes |
| ufr_ruleset | The ruleset for the rule. This is from the perspective of the security gateway. Must be one of WAN\_IN, WAN\_OUT, WAN\_LOCAL, LAN\_IN, LAN\_OUT, LAN\_LOCAL, GUEST\_IN, GUEST\_OUT, GUEST\_LOCAL, WANv6\_IN, WANv6\_OUT, WANv6\_LOCAL, LANv6\_IN, LANv6\_OUT, LANv6\_LOCAL, GUESTv6\_IN, GUESTv6\_OUT, or GUESTv6\_LOCAL | `string` | yes |
| ufr\_src\_address | The source address for the firewall rule | `string` | no  |
| ufr\_src\_firewall\_group\_ids | The source firewall group IDs for the firewall rule | `list` | no  |
| ufr\_src\_mac | The source MAC address of the firewall rule | `string` | no  |
| ufr\_src\_network_id | The source network ID for the firewall rule | `string` | no  |
| ufr\_src\_network_type | The source network type of the firewall rule. Can be one of ADDRv4 or NETv4. Defaults to NETv4 | `string` | no  |
| ufr\_dst\_address | The destination address of the firewall rule | `string` | no  |
| ufr\_dst\_firewall\_group\_ids | The destination firewall group IDs of the firewall rule | `list` | no  |
| ufr\_dst\_network_id | The destination network ID of the firewall rule | `string` | no  |
| ufr\_dst\_network_type | The destination network type of the firewall rule. Can be one of ADDRv4 or NETv4. Defaults to NETv4 | `string` | no  |
| ufr_logging | Enable logging for the firewall rule | `bool` | no  |
| ufr\_state\_new | Match where the state is new | `bool` | no  |
| ufr\_state\_established | Match where the state is established | `bool` | no |
| ufr\_state\_invalid | Match where the state is invalid | `bool` | no  |
| ufr\_state\_related | Match where the state is related | `bool` | no  |
| ufr\_ip\_sec | Specify whether the rule matches on IPsec packets. Can be one of match-ipset or match-none | `string` | no  |

### unifi_network

| Name | Description | Type | Required |
| --- | --- | --- | --- |
| un_enable | Enables or Disables unifi network creation. Defaults to false | `bool` | yes |
| un_name | The name of the network | `string` | yes |
| un_purpose | The purpose of the network. Must be one of corporate, guest, wan, or vlan-only | `string` | no  |
| un\_dhcp\_dns | Specifies the IPv4 addresses for the DNS server to be returned from the DHCP server. Leave blank to disable this feature | `list` | no  |
| un\_dhcp\_enabled | Specifies whether DHCP is enabled or not on this network | bool | no  |
| un\_dhcp\_lease | Specifies the lease time for DHCP addresses. Defaults to 86400 | `number` | no  |
| un\_dhcp\_start | The IPv4 address where the DHCP range of addresses starts | `string` | no  |
| un\_dhcp\_stop | The IPv4 address where the DHCP range of addresses stops | `string` | no  |
| un\_domain\_name | The domain name of this network | `string` | no  |
| un\_igmp\_snooping | Specifies whether IGMP snooping is enabled or not | `bool` | no  |
| un\_ipv6\_interface_type | Specifies which type of IPv6 connection to use. Defaults to none | `string` | no  |
| un\_ipv6\_pd_interface | Specifies which WAN interface to use for IPv6 PD | `string` | no  |
| un\_ipv6\_pd_prefixid | Specifies the IPv6 Prefix ID | `string` | no  |
| un\_ipv6\_ra_enable | Specifies whether to enable router advertisements or not | `bool` | no  |
| un\_ipv6\_static_subnet | Specifies the static IPv6 subnet when ipv6\_interface\_type is 'static' | `string` | no  |
| un\_network\_group | The group of the network. Defaults to LAN | `string` | no  |
| un_subnet | The subnet of the network. Must be a valid CIDR address | `string` | no  |
| un\_vlan\_id | The VLAN ID of the network | `number` | no  |
| un\_wan\_egress_qos | Specifies the WAN egress quality of service. Defaults to 0 | `number` | no  |
| un\_wan\_ip | The IPv4 address of the WAN | `string` | no  |
| un\_wan\_networkgroup | pecifies the WAN network group. Must be one of either WAN, WAN2 or WAN\_LTE\_FAILOVER | `string` | no  |
| un\_wan\_type | Must be one of either disabled or pppoe. Defaults to disabled | `string` | no  |
| un\_wan\_username | Specifies the IPV4 WAN username | `string` | no  |
| un\_x\_wan_password | Specifies the IPV4 WAN password | `string` | no  |

### unifi_wlan

| Name | Description | Type | Required |
| --- | --- | --- | --- |
| uw_enable | Enables or Disables unifi wlan creation. Defaults to false | `bool` | yes |
| uw_name | The SSID of the network | `string` | yes |
| uw_security | The type of WiFi security for this network. Valid values are: wpapsk, wpaeap, and open | `string` | yes |
| uw\_user\_group_id | ID of the user group to use for this network | `string` | yes |
| uw\_ap\_group_ids | IDs of the AP groups to use for this network | `list` | no  |
| uw\_hide\_ssid | Indicates whether or not to hide the SSID from broadcast | `bool` | no  |
| uw\_is\_guest | Indicates that this is a guest WLAN and should use guest behaviors | `bool` | no  |
| uw\_mac\_filter_enabled | Indicates whether or not the MAC filter is turned of for the network | `bool` | no  |
| uw\_mac\_filter_list | List of MAC addresses to filter (only valid if mac\_filter\_enabled is true) | `list` | no  |
| uw\_mac\_filter_policy | MAC address filter policy (only valid if mac\_filter\_enabled is true). Allow or Deny. Defaults to deny | `string` | no  |
| uw\_multicast\_enhance | Specifies whether IGMP snooping is enabled or not | `bool` | no  |
| uw\_network\_id | ID of the network for this SSID | `string` | no  |
| uw_passphrase | Specifies which WAN interface to use for IPv6 PD | `string` | no  |
| uw\_radius\_profile_id | Specifies the IPv6 Prefix ID | `string` | no  |
| uw\_schedule | Start and stop schedules for the WLAN. See Below | `block list` | no  |
| uw_site | The name of the site to associate the wlan with. Defaults to 'default | `string` | no  |
| uw\_vlan\_id | Deprecated - VLAN ID for the network. Set network\_id instead of vlan\_id for controller version >= 6 | `number` | no  |
| uw\_wlan\_group_id | Deprecated - ID of the WLAN group to use for this network. Set ap\_group\_ids instead of wlan\_group\_id for controller version >= 6 | `string` | no  |

### unifi\_wlan schedule (uw\_schedule)

| Name | Description | Type | Required |
| --- | --- | --- | --- |
| block_end | Time of day to end the block | `string` | yes |
| block_start | Time of day to start the block | `string` | yes |
| day\_of\_week | Day of week for the block. Valid values are sun, mon, tue, wed, thu, fri, sat | `string` | yes |

## Outputs

| Name | Description |
| --- | --- |
| ufg-id | Resource unifi\_firewall\_group id |
| ufr-id | Resource unifi\_firewall\_rule id |
| un-id | Resource unifi_network id |
| uw-id | Resource unifi_wlan id |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Help

**Got a question?**

File a GitHub [issue](https://github.com/rkoosaar/terraform-unifi-controller/issues).

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/rkoosaar/terraform-unifi-controller/issues) to report any bugs or file feature requests.

## Copyrights

Copyright © 2020 Raiko Koosaar

### Contributors

[![Raiko Koosaar][rkoosaar_avatar]][rkoosaar_homepage]<br/>[Raiko Koosaar][rkoosaar_homepage]

[rkoosaar_homepage]: https://github.com/rkoosaar
[rkoosaar_avatar]: https://github.com/rkoosaar.png?size=150
[github]: https://github.com/rkoosaar
[share_email]: mailto:?subject=terraform-unifi-controller&body=https://github.com/rkoosaar/terraform-unifi-controller
