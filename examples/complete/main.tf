module "load_balancer" {
  source = "../../"

  name        = "production-lb"
  description = "Production Load Balancer"

  network_id = "subnet-id"

  vpc_id   = "vpc-id"
  vpc_name = "production-vpc"

  ha = true

  virtual_servers = [
    {
      name              = "http"
      protocol          = "HTTP"
      port              = 80
      routing_algorithm = "ROUND_ROBIN"

      interval = 30

      persistence_enabled = true
      persistence_type    = "source_ip"

      x_forwarded_for = true

      nodes = [
        {
          compute_id = 101
          compute_ip = "10.0.1.10"
          port       = 8080
          weight     = 50
        },
        {
          compute_id = 102
          compute_ip = "10.0.1.11"
          port       = 8080
          weight     = 50
        }
      ]
    },

    {
      name              = "https"
      protocol          = "HTTPS"
      port              = 443
      routing_algorithm = "ROUND_ROBIN"

      interval = 30

      persistence_enabled = true
      persistence_type    = "source_ip"

      certificate_id   = "certificate-id"
      monitor_protocol = "HTTPS"

      x_forwarded_for = true

      nodes = [
        {
          compute_id = 101
          compute_ip = "10.0.1.10"
          port       = 8443
          weight     = 50
        },
        {
          compute_id = 102
          compute_ip = "10.0.1.11"
          port       = 8443
          weight     = 50
        }
      ]
    }
  ]
}
