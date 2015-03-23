require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Kicker
  class Application < Rails::Application
    config.time_zone = 'Pacific Time (US & Canada)'

    config.autoload_paths << Rails.root.join('lib')

    config.cache_store = :redis_store, ENV['REDIS_URL']

    config.react.addons = true

    config.react.component_filenames = ['front_end/components.js']

    config.browserify_rails.commandline_options = "-t reactify --extension=\".js.jsx\""

    #ES6ModuleTranspiler.compile_to = :cjs
  end
end