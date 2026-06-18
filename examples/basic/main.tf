module "load_balancer" {
  source = "../../"

  name = "example-lb"

  network_id = "subnet-id"

  vpc_id   = "vpc-id"
  vpc_name = "example-vpc"

  virtual_servers = [
    {
      name              = "http"
      protocol          = "HTTP"
      port              = 80
      routing_algorithm = "ROUND_ROBIN"

      interval = 30

      nodes = [
        {
          compute_id = 101
          compute_ip = "10.0.1.10"
          port       = 8080
        }
      ]
    }
  ]
}
