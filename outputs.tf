output "ufg-id" {
  value = unifi_firewall_group.ufg.*.id
}

output "ufr-id" {
  value = unifi_firewall_rule.ufr.*.id
}

output "un-id" {
  value = unifi_network.un.*.id
}

output "uw-id" {
  value = unifi_wlan.uw.*.id
}