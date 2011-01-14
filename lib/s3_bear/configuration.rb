module S3Bear
  class Configuration

    attr_accessor :access_key_id
    
    attr_accessor :secret_access_key
    
    attr_accessor :bucket
    
    attr_accessor :upload_image_url
    
    attr_accessor :loading_image_url

    def loading_image
      "http://#{self.bucket}.s3.amazonaws.com#{self.loading_image_url}"
    end
    
    # def initialize
    #  
    # end
  end
end
