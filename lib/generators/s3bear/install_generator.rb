module S3Bear
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Copy SimpleForm default files"
      source_root File.expand_path('../templates', __FILE__)
      class_option :template_engine

      def copy_initializers
        copy_file 's3bear.rb', 'config/initializers/s3bear.rb'
      end
    end
  end
end
