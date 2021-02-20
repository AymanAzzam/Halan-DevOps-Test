variable "db_name" {
    default = "add default value here or delete this line"
    type = string
    description = "Enter the database name"
}

variable "db_user" {
    default = "add default value here or delete this line"
    type = string
    description = "Enter the database username"
}

variable "db_password" {
    default = "add default value here or delete this line"
    type = string
    description = "Enter the database password"
}

variable "db_host" {
    default = "add default value here or delete this line"
    type = string
    description = "Enter the database host"
}

variable "public_port" {
    default = 5000
    type = number
    description = "Enter the output port to be used for API"
}

variable "access_key" {
    default = "add default value here or delete this line"
    type = string
    description = "Enter the access key for AWS account"
}

variable "secret_key" {
    default = "add default value here or delete this line"
    type = string
    description = "Enter the secret key for AWS account"
}

variable "key_name" {
    default = "add default value here or delete this line"
    type = string
    description = "Enter the public key name created on AWS"
}
