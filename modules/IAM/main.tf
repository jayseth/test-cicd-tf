#user
resource "aws_iam_user" "new_user" {
  name = "user-1"
}


#group
resource "aws_iam_group" "new_group" {
  name = "Dev"
}




#adding user-1 to group developers

resource "aws_iam_user_group_membership" "new_group" {
  user = aws_iam_user.new_user.name

  groups = [
    aws_iam_group.new_group.name,
    
  ]
}