output "lb_service_id" {
  description = "Load Balancer Service ID"
  value       = airtelcloud_lb_service.this.id
}

output "lb_status" {
  description = "Load Balancer Status"
  value       = airtelcloud_lb_service.this.status
}

output "vip_id" {
  description = "VIP ID"
  value       = airtelcloud_lb_vip.this.id
}

output "public_ip" {
  description = "Public IP"
  value       = airtelcloud_lb_vip.this.public_ip
}

output "virtual_servers" {
  description = "Virtual Server Details"

  value = {
    for name, vs in airtelcloud_lb_virtual_server.this :
    name => {
      id     = vs.id
      vip    = vs.vip
      status = vs.status
    }
  }
}
