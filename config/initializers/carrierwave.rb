CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: 'AKIAIPJAYBIBWVHUJKYQ',
    aws_secret_access_key: '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',
    region: 'ap-northeast-1'
  }

  config.fog_directory = 'pocket-guide-api' if Rails.env.production?
  config.fog_directory = 'pocket-guide-api' if Rails.env.development?

end