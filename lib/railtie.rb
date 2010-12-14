require 's3_bear'
require 'rails'
 
module S3Bear
  class Engine < Rails::Engine
    #engine_name :s3_bear
    #paths.app.controllers = "lib/controllers"
    #paths.config.routes   = "lib/config/routes.rb"
    #initializer :s3_bear_routes, :before => :add_routing_paths do |app|
      # app.routes_reloader.paths.unshift File.join(File.dirname(__FILE__), "config", "routes.rb")
    #end
   # user_homepage_routes = File.join(File.dirname(__FILE__), *%w[.. config routes.rb])
    #config.add_prepended_route_configuration_file(user_homepage_routes)
  end
end