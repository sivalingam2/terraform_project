prod_destroy () {
   rm -rf .terraform
    terraform init -backend-config=env-dev/state.tfvars
    terraform destroy -auto-approve -var-file=env-dev/main.tfvars
}
prod_destroy