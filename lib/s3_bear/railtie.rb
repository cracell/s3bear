require 's3_bear'
require 'rails'
 
module S3Bear
  class Railtie < Rails::Railtie
     railtie_name :s3_bear
     paths.app.controllers = "lib/controllers"
     
     initializer :s3_bear_routes do |app|
       app.routes_reloader.paths << File.join(File.dirname(__FILE__), "..", "..", "lib", "config", "routes.rb")
     end
  end
end