# frozen_string_literal: true

require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
# require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.storage :file
  # config.fog_provider = 'fog/aws'
  # config.fog_directory = 'the-motorcycle-29204'
  # config.fog_credentials = {
  #   provider: 'AWS',
  #   aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
  #   aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
  #   region: 'ap-northeast-1',
  #   path_style: true
  # }
end
