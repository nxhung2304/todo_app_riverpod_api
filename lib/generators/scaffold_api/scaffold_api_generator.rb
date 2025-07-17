require "rails/generators"
require "rails/generators/named_base"

class ScaffoldApiGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)
  argument :attributes, type: :array, default: [], banner: "field[:type] field[:type]"

  def generate_model
    generate "model", "#{file_name} #{attributes.join(' ')}"
  end

  def generate_controller
    template "controller.rb.tt", "app/controllers/api/v1/#{plural_file_name}_controller.rb"
  end

  def generate_serializer
    template "serializer.rb.tt", "app/serializers/#{file_name}_serializer.rb"
  end

  def add_routes
    route "namespace :api do\n    namespace :v1 do\n      resources :#{plural_file_name}\n    end\n  end"
  end
end
