require 'aws/s3'

namespace :s3bear do
  desc "create a bucket according to your setting in initializers/s3bear.rb"
  task :make_bucket => :environment do
    connect_s3!
    AWS::S3::Bucket.create(S3Bear.config.bucket, :access => :public_read_write)
  end

  desc "put a standard crossdomain.xml into your bucket"
  task :make_crossdomain => :environment do
    connect_s3!
    file = File.expand_path(File.join(File.dirname(__FILE__), '../', '../' 'public/crossdomain.xml'))
    AWS::S3::S3Object.store('crossdomain.xml', open(file), S3Bear.config.bucket, :access => :public_read)
  end
  
  desc "put a iframe upload.html into your bucket"
  task :make_upload => :environment do
    connect_s3!
    file = File.expand_path(File.join(File.dirname(__FILE__), '../', '../' 'public/upload.html'))
    AWS::S3::S3Object.store('upload.html', open(file), S3Bear.config.bucket, :access => :public_read)
    file = File.expand_path(File.join(File.dirname(__FILE__), '../', '../' 'public/assets/upload_button.png'))
    AWS::S3::S3Object.store('assets/upload_button.png', open(file), S3Bear.config.bucket, :access => :public_read)
    
    file = File.expand_path(File.join(File.dirname(__FILE__), '../', '../' 'public/assets/s3bear_external.js'))
    AWS::S3::S3Object.store('assets/s3bear_external.js', open(file), S3Bear.config.bucket, :access => :public_read)
    
    file = File.expand_path(File.join(File.dirname(__FILE__), '../', '../' 'public/assets/swfupload.swf'))
    AWS::S3::S3Object.store('assets/swfupload.swf', open(file), S3Bear.config.bucket, :access => :public_read)
    
    file = File.expand_path(File.join(File.dirname(__FILE__), '../', '../' 'public/assets/loader.gif'))
    AWS::S3::S3Object.store('assets/loader.gif', open(file), S3Bear.config.bucket, :access => :public_read)

    # Not working. So switching to uploading straight to bucket for now
    # puts 'hi1'
    # AWS::S3::S3Object.store('raw_uploads/', '', S3Bear.config.bucket)
    # puts 'hi2'
    # policy = AWS::S3::S3Object.acl('raw_uploads/', S3Bear.config.bucket)
    # puts policy.grants
    # puts 'hi3'
    # grant = AWS::S3::ACL::Grant.new
    # grant.permission = 'WRITE'
    # grantee = AWS::S3::ACL::Grantee.new
    # grantee.group = 'AllUsers'
    # grant.grantee = grantee
    # grant
    # policy.grants << grant
    # puts policy.grants
    # puts 'hi4'
    # AWS::S3::S3Object.acl('raw_uploads/', S3Bear.config.bucket, policy)
  end
  
  desc "Create your bucket and uploads required files"
  task :setup_upload_bucket => :enviroment do
    
  end
  
  

  def connect_s3!
    AWS::S3::Base.establish_connection!(
      :access_key_id => S3Bear.config.access_key_id,
      :secret_access_key => S3Bear.config.secret_access_key
    )
  end
end