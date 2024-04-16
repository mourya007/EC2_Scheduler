

resource "aws_lambda_function" "start_function" {
  function_name = "start_ec2_instances"
  handler       = "start.handler"
  role          = aws_iam_role.lambda_execution_role.arn
  runtime       = "python3.8" 
  filename      = "${path.module}/../Lambda/start.zip"

  environment {
    variables = {
      TAG_KEY   = var.tag_key
      TAG_VALUE = var.tag_value
    }
  }
}

resource "aws_lambda_function" "stop_function" {
  function_name = "stop_ec2_instances"
  handler       = "stop.handler"
  role          = aws_iam_role.lambda_execution_role.arn
  runtime       = "python3.8"
  filename      = "${path.module}/../Lambda/stop.zip"

  environment {
    variables = {
      TAG_KEY   = var.tag_key
      TAG_VALUE = var.tag_value
    }
  }
}
resource "aws_cloudwatch_event_rule" "start_instances" {
  name                = "start-instances"
  description         = "Trigger to start EC2 instances"
  schedule_expression = var.schedule_start
}

resource "aws_cloudwatch_event_rule" "stop_instances" {
  name                = "stop-instances"
  description         = "Trigger to stop EC2 instances"
  schedule_expression = var.schedule_stop
}

resource "aws_cloudwatch_event_target" "start_target" {
  rule      = aws_cloudwatch_event_rule.start_instances.name
  arn       = aws_lambda_function.start_function.arn
}

resource "aws_cloudwatch_event_target" "stop_target" {
  rule      = aws_cloudwatch_event_rule.stop_instances.name
  arn       = aws_lambda_function.stop_function.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_start_function" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.start_function.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.start_instances.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_stop_function" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.stop_function.function_name
  principal     = "events.amazonaws.com"
  source_arn     = aws_cloudwatch_event_rule.stop_instances.arn
}