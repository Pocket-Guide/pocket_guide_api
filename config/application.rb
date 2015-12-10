require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PocketGuideApi
  class Application < Rails::Application
    config.generators do |g|
      g.template_engine      false
      g.test_framework       :rspec, view_specs: false, helper_specs: false, fixture: true
      g.helper               false
      g.stylesheets          false
      g.javascripts          false
    end
    config.active_record.raise_in_transactional_callbacks = true
    config.middleware.insert_before 0, "Rack::Cors" do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :options]
      end
    end
  end
end
