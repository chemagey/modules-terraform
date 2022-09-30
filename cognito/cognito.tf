resource "aws_cognito_user_pool" "user_pool" {
  name = var.user_pool

  username_attributes = ["email"]
  auto_verified_attributes = ["email"]
  mfa_configuration = "OFF"
  password_policy {
    minimum_length    = "8"
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  tags = {
    Name        = var.tag_name
    Service     = var.service
    Environment = var.environment
#    Owner       = "TDR"
  }


  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
    email_subject = "Account Confirmation"
    email_message = "Your confirmation code is {####}"
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "email"
    required                 = true

    string_attribute_constraints {
      min_length = 1
      max_length = 256
    }
  }
}


resource "aws_cognito_identity_provider" "saml" {
  user_pool_id  = aws_cognito_user_pool.user_pool.id
  provider_name = var.adfs
  provider_type = "SAML"

  provider_details = {
    MetadataURL = var.saml_metadata_sso_redirect_binding_uri
  }

  attribute_mapping = {
    email = var.mapping
  }
}


resource "aws_cognito_user_pool_client" "client" {
  name = "cognito-client-split-terraform"

  user_pool_id = aws_cognito_user_pool.user_pool.id
  callback_urls = [var.callback]
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = ["openid","email"]
  generate_secret                      = false
  access_token_validity = "1"
  id_token_validity = "1"
  read_attributes = ["email"]
  supported_identity_providers = [aws_cognito_identity_provider.saml.provider_name]
  write_attributes = ["email"]
  refresh_token_validity = 60
  prevent_user_existence_errors = "ENABLED"
  explicit_auth_flows = [
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_ADMIN_USER_PASSWORD_AUTH"
  ]
}

resource "aws_cognito_user_pool_domain" "domain" {
  domain       = "enagas-split-test"
  user_pool_id = aws_cognito_user_pool.user_pool.id
}

