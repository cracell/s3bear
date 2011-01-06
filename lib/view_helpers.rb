module S3Bear
  module ViewHelpers
    # def s3bear_bucket
    #   S3Bear.config.bucket + '.s3.amazonaws.com/upload.html'
    # end
  end
end

ActionView::Base.send(:include, S3Bear::ViewHelpers)