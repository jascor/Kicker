require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Kicker
  class Application < Rails::Application
    config.time_zone = 'Pacific Time (US & Canada)'

    config.autoload_paths << Rails.root.join('lib')

    config.react.addons = true

    config.handlebars.templates_root = 'staff/templates'

    config.react.component_filenames = ['front_end/components.js']
  end
end