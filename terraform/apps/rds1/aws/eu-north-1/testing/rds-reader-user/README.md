# Testing RDS reader IAM user

Apply the parent `testing/` RDS root first. This separate root creates `devops-exercise-testing-eu-north-1-rds-reader-user` with only `rds-db:connect` for the `reader-user` PostgreSQL login declared in `../users.yaml`.

From this directory, run `terraform init`, `terraform plan`, and `terraform apply` yourself. The operator identity needs the updated root `terraform-operator-policy.json` policy before applying. Install the Session Manager plugin and `psql` on your laptop for the connection test.

No access key is managed by Terraform, so its secret does not enter Terraform state. To test from your laptop, create a temporary access key for this IAM user with the operator identity, configure it as a separate AWS CLI profile, and delete it after the test. Open the SSM tunnel as `deployment` (your current AWS identity, or select its profile with `AWS_PROFILE=deployment`); the reader user has no SSM access. Generate the database token with the `rds-reader-user` profile. The PostgreSQL username remains `reader-user`, regardless of the IAM username.

```sh
aws iam create-access-key --user-name "$(terraform output -raw user_name)"
aws configure --profile rds-reader-user
aws --profile rds-reader-user sts get-caller-identity
```

The access key secret is displayed only when created. Store it outside the repository. With the operator credentials, open a tunnel in one terminal from this directory:

```sh
RDS_HOST=$(terraform -chdir=.. output -raw address)
BASTION_ID=$(terraform -chdir=../../../../../../core/aws/eu-north-1/testing/infrastructure output -raw bastion_instance_id)
aws ssm start-session --region eu-north-1 --target "$BASTION_ID" \
  --document-name AWS-StartPortForwardingSessionToRemoteHost \
  --parameters "{\"host\":[\"$RDS_HOST\"],\"portNumber\":[\"5432\"],\"localPortNumber\":[\"15432\"]}"
```

In another terminal, connect with the reader profile. The token is signed for the RDS endpoint, while `psql` connects through the local tunnel:

```sh
RDS_HOST=$(terraform -chdir=.. output -raw address)
PGPASSWORD="$(aws --profile rds-reader-user rds generate-db-auth-token \
  --hostname "$RDS_HOST" --port 5432 --region eu-north-1 --username reader-user)" \
psql "host=127.0.0.1 port=15432 dbname=rds1 user=reader-user sslmode=verify-ca sslrootcert=../rds-eu-north-1-bundle.pem" \
  -c "SELECT current_user, pg_has_role(current_user, 'app_readonly', 'MEMBER') AS readonly;"
```

Expect `reader-user` and `readonly = t`. After testing, delete the access key with `aws iam delete-access-key --user-name "$(terraform output -raw user_name)" --access-key-id "$ACCESS_KEY_ID"`, where `ACCESS_KEY_ID` is the ID returned when you created the key. Then destroy this Terraform root if you no longer need the IAM user.
