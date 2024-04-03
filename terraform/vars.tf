variable "instance_type_test"{
    type = string
    description = "Tipo de instancia a elegir"
    default = "t3.micro"
}

variable "volume_size_test"{
    type = number
    description = "Tamano de volumen"
    default = 8
}
