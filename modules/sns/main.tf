
resource "aws_sns_topic" "user_updates" {
  name            = var.name_sns
  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false,
    "defaultThrottlePolicy": {
      "maxReceivesPerSecond": 1
    }
  }
}
EOF
  tags = var.tags

}

output "aws_sns_topic" {
  value = [
            aws_sns_topic.user_updates.id,
            aws_sns_topic.user_updates.*
          ]

  
}