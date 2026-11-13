# Testing Argo CD bootstrap

This root connects to the private EKS Kubernetes API through the testing VPC's private SSM bastion. It does not require the EKS public endpoint or an allow-list entry for the operator's public IP.

Apply the testing infrastructure first and wait until the bastion is online in SSM. The AWS identity running Terraform needs permission to start an SSM session to the bastion, and the local machine needs the [AWS Session Manager plugin](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html).

From this directory:

```sh
terraform init
terraform plan
terraform apply
```

The tunnel is created ephemerally during Terraform operations and is not stored in state. The Kubernetes provider connects to the local forwarded port with TLS verification disabled because the EKS certificate is issued for the original EKS endpoint, not `127.0.0.1`; transport remains encrypted by the SSM session. The Helm provider does not allow `insecure = true` together with a root certificate setting, so the local endpoint cannot also use the EKS CA in this configuration.
