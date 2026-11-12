0. Ensure all software is installed in the host (awscli, terraform + tfswitch, kubectl)
1. create user `deployment` with policies defined devops-sample-apps/terraform-operator-policy.json
2. create an access and secret key for `deployment` user, and configure these credentials with awscli
3. create tfstate bucket applying `terraform/bootstrap/state-backend` using local tfstate (temporarily remove the backend config). once the bucket has been created, move the tfstate to the bucket and recover the backend config
4. apply infrastructure TF projects in terraform/core/aws/eu-north-1 to create the VPCs and EKS clusters with `terraform apply -var operator_public_cidr=<yourpublicIP>`
5. apply argocd-bootstrap TF projects in terraform/core/aws/eu-north-1 to create the argo installation
