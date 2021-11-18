
resource "aws_autoscaling_schedule" "start-main" {
  scheduled_action_name  = var.scheduled_action_name_start
  min_size               = "%{if var.env == "prod" || var.env == "stress-test"}4%{else}2%{endif}"
  max_size               = "%{if var.env == "prod" || var.env == "stress-test"}4%{else}2%{endif}"
  desired_capacity       = "%{if var.env == "prod" || var.env == "stress-test"}4%{else}2%{endif}"
  recurrence             = var.recurrence_start
  autoscaling_group_name = var.autoscaling_group_name
}

resource "aws_autoscaling_schedule" "stop-main" {
  scheduled_action_name  = var.scheduled_action_name_stop
  min_size               = 0
  max_size               = 0
  desired_capacity       = 0
  recurrence             = var.recurrence_stop
  autoscaling_group_name = var.autoscaling_group_name

}