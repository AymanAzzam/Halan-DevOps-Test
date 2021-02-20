variable "access_key" {
    default = "add your acces key here"
    type = string
    description = "Enter the access key for AWS account"
}

variable "secret_key" {
    default = "add your secret key here"
    type = string
    description = "Enter the secret key for AWS account"
}

variable "db_name" {
    default = "halan"
    type = string
    description = "Enter the database name"
}

variable "db_user" {
    default = "postgres"
    type = string
    description = "Enter the database username"
}

variable "db_password" {
    default = "1357902468"
    type = string
    description = "Enter the database password"
}

variable "public_port" {
    default = 5000
    type = number
    description = "Enter the output port to be used for API"
}

variable "key_name" {
    default = "add default value here or delete this line"
    type = string
    description = "Enter the public key name created on AWS"
}
