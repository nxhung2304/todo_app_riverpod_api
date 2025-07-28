class ApiGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  argument :attributes, type: :array, default: [], banner: "field[:type] field[:type]"

  def generate_controller
    template "controller.rb.tt", "app/controllers/api/v1/#{plural_file_name}_controller.rb"
  end

  def generate_serializer
    template "serializer.rb.tt", "app/serializers/#{file_name}_serializer.rb"
  end

  def add_routes
    route_content = <<-RUBY
    namespace :api do
      resources :#{plural_file_name}
    end
    RUBY

    inject_into_file "config/routes.rb", route_content, after: "Rails.application.routes.draw do\n"
  end

  def show_usage_instructions
    say "\n" + "=" * 50
    say "✅ Generated API Controller Successfully!"
    say "=" * 50
    say "📁 Files created:"
    say "   • app/controllers/api/#{plural_file_name}_controller.rb"
    say "   • app/serializers/#{file_name}_serializer.rb"
    say "   • Updated config/routes.rb"
    say "\n🔗 Available endpoints:"
    say "   GET    /api/#{plural_file_name}     (index)"
    say "   GET    /api/#{plural_file_name}/:id (show)"
    say "   POST   /api/#{plural_file_name}     (create)"
    say "   PATCH  /api/#{plural_file_name}/:id (update)"
    say "   DELETE /api/#{plural_file_name}/:id (destroy)"
    say "=" * 50 + "\n"
  end
end
