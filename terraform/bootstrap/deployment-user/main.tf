resource "aws_iam_user" "deployment" {
  name = "deployment-user"
}

resource "aws_iam_policy" "deployment" {
  name        = "deployment-policy"
  description = "Permissions for the Terraform deployment user."
  policy      = file("${path.root}/terraform-operator-policy.json")
}

resource "aws_iam_user_policy_attachment" "deployment" {
  user       = aws_iam_user.deployment.name
  policy_arn = aws_iam_policy.deployment.arn
}
