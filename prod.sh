prod_env () {
  rm -rf .terraform
  terraform init -backend-config=env-prod/state.tfvars
  terraform apply -auto-approve -var-file=env-prod/main.tfvars
}
prod_env