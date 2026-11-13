# Deployment instructions

This runbook deploys the testing and production EKS environments, bootstraps Argo CD, and optionally creates the testing RDS database.

All commands below are run from the repository root unless stated otherwise.

## Prerequisites

Install and configure:

- AWS CLI
- Terraform `>= 1.17.1` (using `tfswitch` is supported)
- `kubectl`
- AWS Session Manager Plugin, if using the bastion or the optional RDS workflow
- `psql`, if testing PostgreSQL IAM authentication

Use an administrative AWS identity for the initial bootstrap. Do not create the deployment access key in Terraform; the secret must not be stored in Terraform state.

## 1. Create the Terraform state bucket

Path: `terraform/bootstrap/state-backend`

The state-backend root has an S3 backend configured for the bucket it creates. For the first run, initialize it with the backend disabled so its bootstrap state is local. Then copy the state to the bucket and re-enable the s3 backend

## 2. Create the deployment user and policy

Path: `terraform/bootstrap/deployment-user`

The deployment-user root creates IAM user `deployment-user`, customer-managed policy `deployment-policy`, and the policy attachment. The policy document is [`terraform/bootstrap/deployment-user/terraform-operator-policy.json`](terraform/bootstrap/deployment-user/terraform-operator-policy.json).

Create an access key outside Terraform and configure a separate AWS CLI profile:

```sh
aws iam create-access-key --user-name deployment-user
aws configure --profile deployment
export AWS_PROFILE=deployment
```

## 3. Apply core infrastructure

Path: `terraform/core/aws/eu-north-1/testing/infrastructure`
Path: `terraform/core/aws/eu-north-1/production/infrastructure`

Each environment has an independent VPC, EKS cluster, NAT gateway, private bastion, and Terraform state file.

## 4. Bootstrap Argo CD

Path: `terraform/core/aws/eu-north-1/testing/argocd-bootstrap`
Path: `terraform/core/aws/eu-north-1/production/argocd-bootstrap`

The Argo CD roots install Argo CD and the root Applications that track the repository's platform and application manifests.

## 5. Optional testing RDS database

Path: `terraform/apps/rds1/aws/eu-north-1/testing`

The RDS root creates a private PostgreSQL instance, security-group rules, PostgreSQL groups, and roles from `users.yaml`.

To test IAM database authentication, use the separate `rds-reader-user`
