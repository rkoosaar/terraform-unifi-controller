## variables for unifi firewall group

variable "ufg_enable" {
  type        = bool
  description = "Enables or Disables unifi firewall group creation. Defaults to false"
  default     = false
}

variable "ufg_name" {
  description = "The name of the firewall group"
  type        = string
  default     = null
}

variable "ufg_type" {
  description = "The type of the firewall group. Must be one of: address-group, port-group, or ipv6-address-group"
  type        = string
  default     = null
}

variable "ufg_members" {
  description = "The members of the firewall group"
  type        = list
  default     = null
}

## variables for unifi firewall rule 

variable "ufr_enable" {
  type        = bool
  description = "Enables or Disables unifi firewall rule creation. Defaults to false"
  default     = false
}

# Required

variable "ufr_name" {
  description = "The name of the firewall rule"
  type        = string
  default     = null
}

variable "ufr_action" {
  description = "The action of the firewall rule. Must be one of drop, accept, or reject"
  type        = string
  default     = null
}

variable "ufr_protocol" {
  description = "The protocol of the rule. Must be one of all, tcp, udp, tcp and udp, icmp, ah, ax.25, dccp, ddp, egp, eigrip, encap, esp, etherip, fc, ggp, gre, hip, hmp, idpr-cmtp, idrp, igmp, igp, ip, ipcomp, ipencap, ipip, ipv6, ipv6-frag, ipv6-icmp, ipv6-nonxt, ipv6-opts, ipv6-route, is-is, iso-tp4, l2tp, manet, mobility header, mpls-in-ip, ospf, pim, pup, rdp, rohc, rspf, rsvp, sctp, shim6, skip, st, udplite, vmtp, vrrp, wesp, xns-dip, xtp, number"
  type        = string
  default     = null
}

variable "ufr_rule_index" {
  description = "The index of the rule. Must be >= 2000 < 3000 or >= 4000 < 5000"
  type        = number
  default     = null
}

variable "ufr_ruleset" {
  description = "The ruleset for the rule. This is from the perspective of the security gateway. Must be one of WAN_IN, WAN_OUT, WAN_LOCAL, LAN_IN, LAN_OUT, LAN_LOCAL, GUEST_IN, GUEST_OUT, GUEST_LOCAL, WANv6_IN, WANv6_OUT, WANv6_LOCAL, LANv6_IN, LANv6_OUT, LANv6_LOCAL, GUESTv6_IN, GUESTv6_OUT, or GUESTv6_LOCAL"
  type        = string
  default     = null
}

# Optional - Source

variable "ufr_src_address" {
  description = "The source address for the firewall rule"
  type        = string
  default     = null
}

variable "ufr_src_firewall_group_ids" {
  description = "The source firewall group IDs for the firewall rule"
  type        = list
  default     = null
}

variable "ufr_src_mac" {
  description = "The source MAC address of the firewall rule"
  type        = string
  default     = null
}

variable "ufr_src_network_id" {
  description = "The source network ID for the firewall rule"
  type        = string
  default     = null
}

variable "ufr_src_network_type" {
  description = "The source network type of the firewall rule. Can be one of ADDRv4 or NETv4. Defaults to NETv4"
  type        = string
  default     = null
}

# Optional - Destination

variable "ufr_dst_address" {
  description = "The destination address of the firewall rule"
  type        = string
  default     = null
}

variable "ufr_dst_firewall_group_ids" {
  description = "The destination firewall group IDs of the firewall rule"
  type        = list
  default     = null
}

variable "ufr_dst_network_id" {
  description = "The destination network ID of the firewall rule"
  type        = string
  default     = null
}

variable "ufr_dst_network_type" {
  description = "The destination network type of the firewall rule. Can be one of ADDRv4 or NETv4. Defaults to NETv4"
  type        = string
  default     = null
}

# Optional - Advanced

variable "ufr_logging" {
  description = "Enable logging for the firewall rule"
  type        = bool
  default     = null
}

variable "ufr_state_new" {
  description = "Match where the state is new"
  type        = bool
  default     = null
}

variable "ufr_state_established" {
  description = "Match where the state is established"
  type        = bool
  default     = null
}

variable "ufr_state_invalid" {
  description = "Match where the state is invalid"
  type        = bool
  default     = null
}

variable "ufr_state_related" {
  description = "Match where the state is related"
  type        = bool
  default     = null
}

variable "ufr_ip_sec" {
  description = "Specify whether the rule matches on IPsec packets. Can be one of match-ipset or match-none"
  type        = string
  default     = null
}

## variables for unifi network

variable "un_enable" {
  type        = bool
  description = "Enables or Disables unifi network creation. Defaults to false"
  default     = false
}

# Required
variable "un_name" {
  description = "The name of the network"
  type        = string
  default     = null
}

variable "un_purpose" {
  description = "The purpose of the network. Must be one of corporate, guest, wan, or vlan-only"
  type        = string
  default     = null
}

# Optional

variable "un_dhcp_dns" {
  description = "Specifies the IPv4 addresses for the DNS server to be returned from the DHCP server. Leave blank to disable this feature"
  type        = list
  default     = null
}

variable "un_dhcp_enabled" {
  description = "Specifies whether DHCP is enabled or not on this network"
  type        = bool
  default     = null
}

variable "un_dhcp_lease" {
  description = "Specifies the lease time for DHCP addresses. Defaults to 86400"
  type        = number
  default     = null
}

variable "un_dhcp_start" {
  description = "The IPv4 address where the DHCP range of addresses starts"
  type        = string
  default     = null
}

variable "un_dhcp_stop" {
  description = "The IPv4 address where the DHCP range of addresses stops"
  type        = string
  default     = null
}

variable "un_domain_name" {
  description = "The domain name of this network"
  type        = string
  default     = null
}

variable "un_igmp_snooping" {
  description = "Specifies whether IGMP snooping is enabled or not"
  type        = bool
  default     = null
}

variable "un_ipv6_interface_type" {
  description = "Specifies which type of IPv6 connection to use. Defaults to none"
  type        = string
  default     = null
}

variable "un_ipv6_pd_interface" {
  description = "Specifies which WAN interface to use for IPv6 PD"
  type        = string
  default     = null
}

variable "un_ipv6_pd_prefixid" {
  description = "Specifies the IPv6 Prefix ID"
  type        = string
  default     = null
}

variable "un_ipv6_ra_enable" {
  description = "Specifies whether to enable router advertisements or not"
  type        = bool
  default     = null
}

variable "un_ipv6_static_subnet" {
  description = "Specifies the static IPv6 subnet when ipv6_interface_type is 'static'"
  type        = string
  default     = null
}

variable "un_network_group" {
  description = "The group of the network. Defaults to LAN"
  type        = string
  default     = null
}

variable "un_subnet" {
  description = "The subnet of the network. Must be a valid CIDR address"
  type        = string
  default     = null
}

variable "un_vlan_id" {
  description = "The VLAN ID of the network"
  type        = number
  default     = null
}

variable "un_wan_egress_qos" {
  description = "Specifies the WAN egress quality of service. Defaults to 0"
  type        = number
  default     = null
}

variable "un_wan_ip" {
  description = "The IPv4 address of the WAN"
  type        = string
  default     = null
}

variable "un_wan_networkgroup" {
  description = "Specifies the WAN network group. Must be one of either WAN, WAN2 or WAN_LTE_FAILOVER"
  type        = string
  default     = null
}

variable "un_wan_type" {
  description = "Must be one of either disabled or pppoe. Defaults to disabled"
  type        = string
  default     = null
}

variable "un_wan_username" {
  description = "Specifies the IPV4 WAN username"
  type        = string
  default     = null
}

variable "un_x_wan_password" {
  description = "Specifies the IPV4 WAN password"
  type        = string
  default     = null
}