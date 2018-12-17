CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:               Rails.application.secrets.fog_provider,
    region:                 Rails.application.secrets.fog_region,
    local_root:             Rails.application.secrets.fog_local_root,
    endpoint:               Rails.application.secrets.fog_endpoint,
    aws_access_key_id:      Rails.application.secrets.aws_access_key_id,
    aws_secret_access_key:  Rails.application.secrets.aws_secret_access_key
  }

  config.fog_directory  = Rails.application.secrets.fog_directory
  config.fog_public     = false
  config.fog_attributes = { 'Cache-Control' => 'max-age=315576000' }
end
