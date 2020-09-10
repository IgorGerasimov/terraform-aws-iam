
provider "aws" {
  region = "eu-west-1"
}

module "iam_group_developers" {
  source                   = "terraform-aws-modules/iam/aws//modules/iam-group-with-assumable-roles-policy"
  version                  = "~> 2.0"
  name                     = "Developers"
  group_users              = [ for user in toset(var.Developers): module.iam_user_developers[user].this_iam_user_name ]

  assumable_roles = [
  "arn:aws:iam::835367859854:role/developers"  # these roles can be created using `iam_assumable_roles` submodule
  ]

}

module "iam_group_ops" {
  source                   = "terraform-aws-modules/iam/aws//modules/iam-group-with-assumable-roles-policy"
  version                  = "~> 2.0"
  name                     = "Ops"
  group_users              = [ for user in toset(var.Ops): module.iam_user_ops[user].this_iam_user_name ]

  assumable_roles = [
  "arn:aws:iam::835367859854:role/ops"  # these roles can be created using `iam_assumable_roles` submodule
  ]
}

module "iam_user_developers" {
  for_each                      = toset(var.Developers)
  source                        = "terraform-aws-modules/iam/aws//modules/iam-user"
  version                       = "~> 2.0"
  name                          = "${each.key}"
  force_destroy                 = true
  create_iam_user_login_profile = true
  create_iam_access_key         = false
  pgp_key                       = "keybase:test"
}

module "iam_user_ops" {
  for_each                      = toset(var.Ops)
  source                        = "terraform-aws-modules/iam/aws//modules/iam-user"
  version                       = "~> 2.0"
  name                          = "${each.key}"
  force_destroy                 = true
  create_iam_user_login_profile = true
  create_iam_access_key         = false
  pgp_key                       = "keybase:test"
}

module "iam_assumable_role_develop" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 2.0"

  trusted_role_arns = [
    "arn:aws:iam::873772212348:user/example",
  ]

  create_role = true

  role_name         = "developers"
  role_requires_mfa = true

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonCognitoReadOnly",
    "arn:aws:iam::aws:policy/AlexaForBusinessFullAccess",
  ]
}

module "iam_assumable_role_ops" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 2.0"

  trusted_role_arns = [
    "arn:aws:iam::873773222348:user/example",
  ]

  create_role = true

  role_name         = "ops"
  role_requires_mfa = true

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonCognitoReadOnly",
    "arn:aws:iam::aws:policy/AlexaForBusinessFullAccess",
  ]
}