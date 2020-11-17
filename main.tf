# unifi_firewall_group manages groups of addresses or ports for use in firewall rules (unifi_firewall_rule).

resource "unifi_firewall_group" "ufg" {
  count   = var.ufg_enable ? 1 : 0
  name    = var.ufg_name
  type    = var.ufg_type
  members = var.ufg_members
}

# unifi_firewall_rule manages an individual firewall rule on the gateway.

resource "unifi_firewall_rule" "ufr" {
  count = var.ufr_enable ? 1 : 0

  # Required
  name     = var.ufr_name
  action   = var.ufr_action
  protocol = var.ufr_protocol

  rule_index = var.ufr_rule_index
  ruleset    = var.ufr_ruleset #type in GUI

  # Optional - Source
  src_address            = var.ufr_src_address
  src_firewall_group_ids = var.ufr_src_firewall_group_ids
  src_mac                = var.ufr_src_mac
  src_network_id         = var.ufr_src_network_id
  src_network_type       = var.ufr_src_network_type

  # Optional - Destination
  dst_address            = var.ufr_dst_address
  dst_firewall_group_ids = var.ufr_dst_firewall_group_ids
  dst_network_id         = var.ufr_dst_network_id
  dst_network_type       = var.ufr_dst_network_type

  # Optional - Advanced
  logging           = var.ufr_logging
  state_new         = var.ufr_state_new
  state_established = var.ufr_state_established
  state_invalid     = var.ufr_state_invalid
  state_related     = var.ufr_state_related
  ip_sec            = var.ufr_ip_sec
}

resource "unifi_network" "un" {
  count = var.un_enable ? 1 : 0

  # Required 
  name    = var.un_name
  purpose = var.un_purpose

  # Optional
  dhcp_dns            = var.un_dhcp_dns
  dhcp_enabled        = var.un_dhcp_enabled
  dhcp_lease          = var.un_dhcp_lease
  dhcp_start          = var.un_dhcp_start
  dhcp_stop           = var.un_dhcp_stop
  domain_name         = var.un_domain_name
  igmp_snooping       = var.un_igmp_snooping
  ipv6_interface_type = var.un_ipv6_interface_type
  ipv6_pd_interface   = var.un_ipv6_pd_interface
  ipv6_pd_prefixid    = var.un_ipv6_pd_prefixid
  ipv6_ra_enable      = var.un_ipv6_ra_enable
  ipv6_static_subnet  = var.un_ipv6_static_subnet
  network_group       = var.un_network_group
  subnet              = var.un_subnet
  vlan_id             = var.un_vlan_id
  wan_egress_qos      = var.un_wan_egress_qos
  wan_ip              = var.un_wan_ip
  wan_networkgroup    = var.un_wan_networkgroup
  wan_type            = var.un_wan_type
  wan_username        = var.un_wan_username
  x_wan_password      = var.un_x_wan_password
}

resource "unifi_wlan" "uw" {
  count = var.uw_enable ? 1 : 0

  # Required
  name          = var.uw_name
  security      = var.uw_security
  user_group_id = var.uw_user_group_id

  # Optional
  ap_group_ids       = var.uw_ap_group_ids
  hide_ssid          = var.uw_hide_ssid
  is_guest           = var.uw_is_guest
  mac_filter_enabled = var.uw_mac_filter_enabled
  mac_filter_list    = var.uw_mac_filter_list
  mac_filter_policy  = var.uw_mac_filter_policy
  multicast_enhance  = var.uw_multicast_enhance
  network_id         = var.uw_network_id
  passphrase         = var.uw_passphrase
  radius_profile_id  = var.uw_radius_profile_id

  dynamic "schedule" {
    for_each = var.uw_schedule
    content {
      block_end   = schedule.value.block_end
      block_start = schedule.value.block_start
      day_of_week = schedule.value.day_of_week
    }
  }

  site          = var.uw_site
  vlan_id       = var.uw_vlan_id
  wlan_group_id = var.uw_wlan_group_id
}
