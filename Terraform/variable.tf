variable "schedule_start" {
  description = "8:00 AM in every morning."
  default     = "cron(0 8 ? * 2-6 *)"
}

variable "schedule_stop" {
  description = ""
      default     = "cron(0 17 ? * 2-6 *)"
}

variable "tag_key" {
  description = "The tag key to filter instances by."
  default     = "AutoStartStop"
}

variable "tag_value" {
  description = "The tag value to filter instances for starting and stopping."
  default     = "true"
}