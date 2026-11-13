resource "aws_iam_user" "reader" {
  name = "devops-exercise-testing-eu-north-1-rds-reader-user"
}

resource "aws_iam_user_policy" "rds_connect" {
  name = "rds1-reader-user-connect"
  user = aws_iam_user.reader.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "rds-db:connect"
      Resource = data.terraform_remote_state.rds.outputs.iam_db_connect_arns["reader-user"]
    }]
  })
}
