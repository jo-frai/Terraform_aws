# Variables definies dans un fichier terraform.tfvars
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

# Definition d'un zone par default ici Paris
variable "AWS_REGION" {
    default = "eu-west-3"
}
