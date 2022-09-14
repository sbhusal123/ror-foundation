CarrierWave.configure do |config|
    config.fog_credentials = {
        :provider => "AWS",
        :aws_access_key_id => ENV["AWS_ACCESS_KEY_IDs"],
        :aws_secret_access_key => ENV["AWS_SECRET_ACCESS_KEY"]
    }

    config.fog_directory = ENV["AWS_BUCKET"]
    confg.fog_public = false
end