resource "aws_lb_target_group_attachment" "target-group-one" {
  target_group_arn = var.target_group_arn
  target_id = each.value
  port = var.target_group_port

  for_each = var.target_group_one_ids
}

resource "aws_lb_target_group_attachment" "target-group-two" {
  target_group_arn = var.target_group_arn
  target_id = each.value
  port = var.target_group_port

  for_each = var.target_group_two_ids
}
