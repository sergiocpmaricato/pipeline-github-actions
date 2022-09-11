variable "location" {
  description = "Variavel que indica a região onde os recursos vão ser criados!"
  type        = string
  default     = "Brazil South"

}

variable "vm_pub_key"{
  description = "Chave publica SSH"
  type = string
}

variable "vm_private_key"{
  description = "Chave privada SSH"
  type = string
}
