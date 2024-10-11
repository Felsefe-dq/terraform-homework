variable "users" {
  type    = set(string)
  default = ["jenny", "rose", "lisa", "jisoo"]
}
resource "aws_iam_user" "example" {
  for_each = var.users
  name     = each.value
}



variable "users2" {
  type    = set(string)
  default = ["jihyo", "sana", "momo", "dahyun"]
}
resource "aws_iam_user" "example2" {
  for_each = var.users2
  name     = each.value
}




resource "aws_iam_group" "cd1" {
  name = "blackpink"
}


resource "aws_iam_group" "cd2" {
  name = "twice"
}


resource "aws_iam_group_membership" "team1" {
  name = "group"

  users = [
    for i in aws_iam_user.example : i.name
  ]

  group = aws_iam_group.cd1.name
}

resource "aws_iam_group_membership" "team2" {
  name = "group2"

  users = [
    for i in aws_iam_user.example2 : i.name
  ]

  group = aws_iam_group.cd2.name
}



resource "aws_iam_user" "lb" {
  name = "miyeon"
}

resource "aws_iam_user" "lb2" {
  name = "mina"
}

# Used terraform import with the name of the resource
# terraform import aws_iam_user.lb2 mina
# terraform import aws_iam_user.lb miyeon

resource "aws_iam_group_membership" "manual" {
  name = "tf-testing-group-membership"

  users = [
    aws_iam_user.lb.name,
  ]

  group = aws_iam_group.cd1.name
}

resource "aws_iam_group_membership" "manual2" {
  name = "tf-testing-group-membership2"

  users = [
    aws_iam_user.lb2.name,
  ]

  group = aws_iam_group.cd2.name
}


