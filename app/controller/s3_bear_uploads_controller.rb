require 'base64'

class S3BearUploadsController < ActionController::Base

  # You might want to look at https and expiration_date below.
  #        Possibly these should also be configurable from S3Config...

  skip_before_filter :verify_authenticity_token
  include S3Bear::Signature
  
  def index
    bucket          = S3Bear::Config.bucket
    access_key_id   = S3Bear::Config.access_key_id
    acl             = S3Bear::Config.acl
    secret_key      = S3Bear::Config.secret_access_key
    key             = params[:key]
    content_type    = params[:content_type]
    https           = 'false'
    error_message   = ''
    expiration_date = 1.hours.from_now.utc.strftime('%Y-%m-%dT%H:%M:%S.000Z')

    policy = Base64.encode64(
"{
    'expiration': '#{expiration_date}',
    'conditions': [
        {'bucket': '#{bucket}'},
        {'key': '#{key}'},
        {'acl': '#{acl}'},
        {'Content-Type': '#{content_type}'},
        {'Content-Disposition': 'attachment'},
        ['starts-with', '$Filename', ''],
        ['eq', '$success_action_status', '201']
    ]
}").gsub(/\n|\r/, '')
    signature = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('sha1'), secret_key, policy)).gsub("\n","")

    respond_to do |format|
      format.xml {
        render :xml => {
          :policy          => policy,
          :signature       => signature,
          :bucket          => bucket,
          :accesskeyid     => access_key_id,
          :acl             => acl,
          :expirationdate  => expiration_date,
          :https           => https,
          :errorMessage    => error_message.to_s
        }.to_xml
      }
      format.json {
        render :json => {
          :policy          => policy,
          :signature       => signature,
          :bucket          => bucket,
          :accesskeyid     => access_key_id,
          :acl             => acl,
          :expirationdate  => expiration_date,
          :https           => https,
          :errorMessage    => error_message.to_s
        }
      }
    end
  end
  

end
