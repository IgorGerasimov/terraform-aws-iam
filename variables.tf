variable "Developers" {
  description = "Create IAM Developers users with these names"
  type        = list(string)
  default = ["Eugene", "Milo", "Abigail", "Aidan"]
}

variable "Ops" {
  description = "Create IAM OPS users with these names"
  type        = list(string)
  default = ["Santiago", "Felix", "Morgan"]
}