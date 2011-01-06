module S3Bear
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Copy S3Bear default files"
      source_root File.expand_path('../templates', __FILE__)
      class_option :template_engine

      def copy_initializers
        copy_file 's3bear.rb', 'config/initializers/s3bear.rb'
      end
      
      def copy_javascripts
        copy_file 's3bear.js', 'public/javascripts/s3bear.js'
        copy_file 'postmessage.js', 'public/javascripts/postmessage.js'
      end
      
      def copy_partial
        copy_file '_s3bear.html.haml', 'app/views/shared/_s3bear.html.haml'
      end
      
      def copy_css
        copy_file 's3bear.css', 'public/stylesheets/s3bear.css'
      end
    end
  end
end
