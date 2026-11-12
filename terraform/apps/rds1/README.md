# rds1 (testing)

`aws/eu-north-1/testing/` provisions one PostgreSQL RDS instance through the shared `terraform/apps/modules/aws-rds` module. It reads the testing VPC, private subnets, and EKS cluster name from the core infrastructure state. The database stays private; its security group allows PostgreSQL traffic from the EKS cluster security group.

From this directory, after applying `terraform/core/aws/eu-north-1/testing/infrastructure` and updating the deployment user's IAM policy from `terraform-operator-policy.json`:

```sh
cd aws/eu-north-1/testing
terraform init
terraform plan
terraform apply
terraform output
```

The master password is generated and stored by RDS in Secrets Manager. Terraform outputs its secret ARN, not its value. IAM database authentication is enabled, but database users and `rds-db:connect` permissions are not created here. This testing instance uses one AZ and skips the final snapshot on deletion; it keeps automated backups for seven days while running. It does not configure either sample application to connect to the database.
