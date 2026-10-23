# Terraform

## Requirements

* Change values in terraform.tfvars to your preferred values

## Build on AWS

* Move into terraform/environments/staging or prod

* terraform init <!-- initialize the modules -->
* terraform validate <!-- check if the code is valid -->
* terraform plan <!-- plan to see what would be changed in the cloud -->
* terraform apply <!-- apply the code and build on the cloud -->

## Destroy when done

* terraform destroy