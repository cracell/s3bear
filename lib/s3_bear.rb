module S3Bear
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
      io = open(URI.parse(self.send(self.class.url_path)))
      def io.original_filename; base_uri.path.split('/').last; end
      io.original_filename.blank? ? nil : io
    rescue # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
    end
    
    private :image_url_provided?, :download_remote_image, :do_download_remote_image
  end
end

ActiveRecord::Base.send :include, S3Bear