# Airtel Cloud Load Balancer Terraform Module

Terraform module for provisioning Airtel Cloud Load Balancers.

## Features

* Creates Load Balancer Services
* Creates VIPs automatically
* Creates one or more Virtual Servers
* Supports HTTP, HTTPS, TCP and UDP
* Supports Session Persistence
* Supports X-Forwarded-For
* Supports Backend Node Configuration
* Supports High Availability

## Usage

### Basic Example

```hcl
module "load_balancer" {
  source = "Airtel-Cloud-Platform/load-balancer/airtelcloud"

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
```

## Inputs

| Name            | Description                  | Required |
| --------------- | ---------------------------- | -------- |
| name            | Load Balancer Name           | Yes      |
| network_id      | Subnet ID                    | Yes      |
| vpc_id          | VPC ID                       | Yes      |
| vpc_name        | VPC Name                     | Yes      |
| virtual_servers | Virtual Server Configuration | Yes      |
| description     | Description                  | No       |
| ha              | High Availability            | No       |

## Outputs

| Name          | Description              |
| ------------- | ------------------------ |
| lb_service_id | Load Balancer Service ID |
| lb_status     | Load Balancer Status     |
| vip_id        | VIP ID                   |
| public_ip     | Public IP                |
| vip_address   | Virtual IP               |

## Backend Node Requirement

The compute_id inside nodes expects the Airtel Cloud provider compute numeric ID.

Example:

```hcl
nodes = [
  {
    compute_id = 101
    compute_ip = "10.0.1.10"
    port       = 8080
  }
]
```

Do not use VM UUID values.

## Requirements

| Name                  | Version  |
| --------------------- | -------- |
| Terraform             | >= 1.5   |
| Airtel Cloud Provider | >= 1.0.4 |
| }                     |          |

