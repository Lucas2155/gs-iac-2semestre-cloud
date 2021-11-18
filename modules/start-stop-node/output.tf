output "aws_autoscaling_schedule_start" {
  value = [aws_autoscaling_schedule.start-main.scheduled_action_name, aws_autoscaling_schedule.start-main.recurrence]
}

output "aws_autoscaling_schedule_stop" {
  value = [aws_autoscaling_schedule.stop-main.scheduled_action_name, aws_autoscaling_schedule.stop-main.recurrence]
}
