module ApiApp
  class Application < Rails::Application
   
    config.autoload_paths << Rails.root.join('lib')
    
    end
   end

