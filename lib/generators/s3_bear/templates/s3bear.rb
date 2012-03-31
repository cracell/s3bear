S3Bear.config do |config|
  config.access_key_id = ENV['S3_ACCESS_KEY_ID'] #Your S3 Access Key ID
  config.secret_access_key = ENV['S3_SECRET_ACCESS_KEY'] #Your S3 Secret Access Key
  config.bucket = 's3bear' #The bucket to upload to on S3
  #config.upload_image_url = 'example' #Custom Upload Image URL
  #config.loading_image = '/assets/layouts/user/loader.gif' #Custom Loading Image URL
end