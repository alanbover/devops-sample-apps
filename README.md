# devops-sample-apps

Both applications share this repository to simplify exercise review; in a real environment, they should have separate repositories.

Application source and Helm charts live under `apps/`; Argo CD deployment configuration lives under `deployment/`.

- TOEXPLAIN: Add repository structure

## Network address plan

Reserve a separate private `/20` CIDR for each independent VPC:

| Region | Environment | Reserved VPC CIDR |
| --- | --- | --- |
| `eu-north-1` | testing | `10.20.0.0/20` |
| `eu-north-1` | production | `10.20.16.0/20` |

These ranges do not overlap. Keep the reservations in Terraform configuration for this exercise; AWS VPC IPAM can centrally allocate and audit them as more regions or accounts are added.

## Releases

App changes with Conventional Commit messages open or update app-specific Release Please pull requests. Merging a release PR creates the GitHub release and publishes the image to GHCR with version, `master`, and commit SHA tags.

## Security improvements

- GHCR packages are public for the exercise; in a real environment, make them private and use scoped Docker registry credentials (`imagePullSecret`).
- Workflows use GitHub-hosted runners; in a real environment, use hardened, organization-managed private runners with enough capacity for availability.
- The Go app binds to port 80. We leave its code unchanged for this exercise, so its non-root container needs `NET_BIND_SERVICE`; in a real environment, make the port configurable and use an unprivileged port.
- TO EXPLAIN: use different AWS accounts for dev and prod, and one for mgmt (tf buckets)
- TO EXPLAIN: make EKS api private (currently open to my home public IP only) using either a bastion host or a VPN
- TO EXPLAIN AND REASON: Use SSO user or a aws login for deployment user



## Reliability improvements
- PHP workaround: the image includes both repo configs; its wrapper copies `config.prod` only for `APP_ENV=prod`, so testing environment fails. In a real environment, runtime should provide environment-specific config, we should avoid baking it into the image. In case having environment-specific configs living together with the app is a hard requirement, the app should select the right one itself and need no wrapper.
