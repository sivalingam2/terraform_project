prod_destroy () {
  rm -rf .terraform
  terraform init -backend-config=env-prod/state.tfvars
  terraform destroy -auto-approve -var-file=env-prod/main.tfvars
}
prod_destroy