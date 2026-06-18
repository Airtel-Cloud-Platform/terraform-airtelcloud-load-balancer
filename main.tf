resource "airtelcloud_lb_service" "this" {
  name        = var.name
  description = var.description

  network_id = var.network_id

  vpc_id   = var.vpc_id
  vpc_name = var.vpc_name

  ha = var.ha
}

resource "airtelcloud_lb_vip" "this" {
  lb_service_id = airtelcloud_lb_service.this.id
}

resource "airtelcloud_lb_virtual_server" "this" {
  for_each = {
    for vs in var.virtual_servers :
    vs.name => vs
  }

  lb_service_id = airtelcloud_lb_service.this.id

  vip_port_id = tonumber(airtelcloud_lb_vip.this.id)

  name = each.value.name

  protocol          = each.value.protocol
  port              = each.value.port
  routing_algorithm = each.value.routing_algorithm

  vpc_id = var.vpc_id

  interval = each.value.interval

  nodes = each.value.nodes

  persistence_enabled = try(each.value.persistence_enabled, false)
  persistence_type    = try(each.value.persistence_type, null)

  x_forwarded_for = try(each.value.x_forwarded_for, false)

  redirect_https = try(each.value.redirect_https, false)

  certificate_id = try(each.value.certificate_id, null)

  monitor_protocol = try(each.value.monitor_protocol, null)
}
