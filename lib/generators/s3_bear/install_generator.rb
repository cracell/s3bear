module S3Bear
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Copy S3Bear default files"
      source_root File.expand_path('../templates', __FILE__)
      class_option :template_engine

      def copy_initializers
        copy_file 's3bear.rb', 'config/initializers/s3bear.rb'
      end
      
      def copy_partial
        copy_file '_s3bear.html.haml', 'app/views/shared/_s3bear.html.haml'
      end
    end
  end
end
