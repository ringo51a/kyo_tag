require 'carrierwave/storage/abstract'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
    config.storage :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory  = 'kyo-tag-s3' # 作成したバケット名を記述
    config.fog_public = false
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.credentials.aws_access_key_id, # 環境変数
      aws_secret_access_key: Rails.application.credentials.aws_secret_access_key, # 環境変数
      region: 'ap-northeast-1',   # アジアパシフィック(東京)を選択
      path_style: true
    }
end
