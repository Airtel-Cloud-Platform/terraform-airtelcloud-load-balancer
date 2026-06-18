variable "name" {
  description = "Load Balancer Name"
  type        = string

  validation {
    condition     = length(trim(var.name, " ")) > 0
    error_message = "name cannot be empty."
  }
}

variable "description" {
  description = "Load Balancer Description"
  type        = string
  default     = null
}

variable "network_id" {
  description = "Subnet ID"
  type        = string

  validation {
    condition     = length(trim(var.network_id, " ")) > 0
    error_message = "network_id cannot be empty."
  }
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string

  validation {
    condition     = length(trim(var.vpc_id, " ")) > 0
    error_message = "vpc_id cannot be empty."
  }
}

variable "vpc_name" {
  description = "VPC Name"
  type        = string

  validation {
    condition     = length(trim(var.vpc_name, " ")) > 0
    error_message = "vpc_name cannot be empty."
  }
}

variable "ha" {
  description = "Enable High Availability"
  type        = bool
  default     = false
}

variable "virtual_servers" {
  description = "Virtual Servers"

  type = list(object({
    name              = string
    protocol          = string
    port              = number
    routing_algorithm = string
    interval          = number

    persistence_enabled = optional(bool)
    persistence_type    = optional(string)

    x_forwarded_for = optional(bool)

    redirect_https = optional(bool)

    certificate_id   = optional(string)
    monitor_protocol = optional(string)

    nodes = list(object({
      compute_id = number
      compute_ip = string
      port       = number
      weight     = optional(number)
      max_conn   = optional(number)
    }))
  }))

  validation {
    condition     = length(var.virtual_servers) > 0
    error_message = "At least one virtual server must be defined."
  }

  validation {
    condition = alltrue([
      for vs in var.virtual_servers :
      contains(
        ["HTTP", "HTTPS", "TCP", "UDP"],
        vs.protocol
      )
    ])

    error_message = "protocol must be HTTP, HTTPS, TCP, or UDP."
  }

  validation {
    condition = alltrue([
      for vs in var.virtual_servers :
      contains(
        ["ROUND_ROBIN", "LEAST_CONNECTIONS"],
        vs.routing_algorithm
      )
    ])

    error_message = "routing_algorithm must be ROUND_ROBIN or LEAST_CONNECTIONS."
  }

  default = []
}
