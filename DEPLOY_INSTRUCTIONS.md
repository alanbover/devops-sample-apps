0. Ensure all software is installed on the host (AWS CLI, Terraform + tfswitch, kubectl, and the AWS Session Manager plugin for the optional RDS tunnel)
1. create user `deployment` with the single policy in `terraform-operator-policy.json` before applying core infrastructure, which creates a private SSM host in each environment
   The policy covers any AWS region using the repository's `devops-exercise-*` resource names and `devops-sample-apps-tfstate-*` bucket prefix. If the separate bastion policy was previously attached, detach it after replacing the operator policy with this merged version.
2. create an access and secret key for `deployment` user, and configure these credentials with awscli
3. create tfstate bucket applying `terraform/bootstrap/state-backend` using local tfstate (temporarily remove the backend config). once the bucket has been created, move the tfstate to the bucket and recover the backend config
4. apply infrastructure TF projects in terraform/core/aws/eu-north-1 to create the VPCs and EKS clusters with `terraform apply -var operator_public_cidr=<yourpublicIP>`
5. apply argocd-bootstrap TF projects in terraform/core/aws/eu-north-1 to create the argo installation
6. for the optional testing database, wait for the testing core host to register with SSM, edit `terraform/apps/rds1/aws/eu-north-1/testing/users.yaml`, then apply `terraform/apps/rds1/aws/eu-north-1/testing` once. See `terraform/apps/rds1/README.md` for the commands and IAM database access step
