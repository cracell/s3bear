#$LOAD_PATH.push File.expand_path(File.dirname(__FILE__))
#require 'railtie'
#require File.join(File.dirname(__FILE__), "prepend_engine_routes")
require File.join(File.dirname(__FILE__), "railtie")
require File.join(File.dirname(__FILE__), "view_helpers")
require "s3_bear/engine"

module S3Bear
  extend ActiveSupport::Autoload

  LIBPATH = File.dirname(__FILE__)

  autoload :Configuration
  
  mattr_accessor :configuration
  def self.config
    self.configuration ||= Configuration.new
    block_given? ? yield(configuration) : configuration
  end

#  class Config
    # cattr_reader :access_key_id, :secret_access_key
    # cattr_accessor :bucket, :max_file_size, :acl
    # def self.load
    #   begin
    #     #filename = "#{Rails.root}/config/amazon_s3.yml"
    #     #file = File.open(filename)
    #     #config = YAML.load(file)[Rails.env]
    # 
    #     if config == nil
    #       raise "Could not load config options for #{Rails.env} from #{filename}."
    #     end
    # 
    #     @@access_key_id     = config['access_key_id']
    #     @@secret_access_key = config['secret_access_key']
    #     @@bucket            = config['bucket']
    #     @@max_file_size     = config['max_file_size']
    #     @@acl               = config['acl'] || 'private'
    # 
    #   
    #   
    #     unless @@access_key_id && @@secret_access_key && @@bucket
    #       raise "Please configure your S3 settings in #{filename} before continuing so that S3 SWF Upload can function properly."
    #     end
    #   rescue Errno::ENOENT
    #      # Using put inside a rake task may mess with some rake tasks
    #      # According to: https://github.com/mhodgson/s3-swf-upload-plugin/commit/f5cc849e1d8b43c1f0d30eb92b772c10c9e73891
    #      # Going to comment this out for the time being
    #      # NCC@BNB - 11/16/10
    #      # No config file yet. Not a big deal. Just issue a warning
    #      # puts "WARNING: You are using the S3 SWF Uploader gem, which wants a config file at #{filename}, " +
    #      #    "but none could be found. You should try running 'rails generate s3_swf_upload:uploader'"
    #   end
    # end
 # end
  
  def self.included(base)
    base.send :extend, ClassMethods
  end
 
  module ClassMethods
    def bearify(field_name)
      cattr_accessor :field_name
      cattr_accessor :url_path
      self.url_path = (field_name.to_s + '_url').to_sym
      self.field_name = field_name.to_s
      #Add the accessors
      attr_accessor url_path 
      #@url_field = (field_name.to_s + '_url').to_sym
      #self.url_field = self.send(field_name.to_sym)
      before_validation :download_remote_image, :if => :image_url_provided?
      validates_presence_of url_path, :if => :image_url_provided?, :message => 'is invalid or inaccessible'
       
      send :include, InstanceMethods
    end
  end
 
  module InstanceMethods
      
    def image_url_provided?
      !self.send(self.class.url_path).blank?
    end

    def download_remote_image
      self.send((self.class.field_name + '='), do_download_remote_image)
    end

    def do_download_remote_image
      #In case Rails already escaped the URI, we don't want to double escape so decode it first
      url = URI.decode(self.send(self.class.url_path))
      url = URI.escape(url)
      io = open(URI.parse(url))
      def io.original_filename; base_uri.path.split('/').last; end
      io.original_filename.blank? ? nil : io
    rescue #OpenURI::HTTPError => error # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
      #puts error
    end
    
    private :image_url_provided?, :download_remote_image, :do_download_remote_image
  end
end

ActiveRecord::Base.send :include, S3Bear