require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Achievelist
  class Application < Rails::Application
    config.api_only = true

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local

    config.middleware.use ActionDispatch::Cookies

    # 独自設定
    config.x.jwt.issuer = 'achievelist'
    config.x.jwt.expiration_minutes_access = '120'
    config.x.jwt.expiration_minutes_refresh = '1440'

    config.x.base_dir = '/achievelist/'
    config.x.filepath_private_key = "#{config.x.base_dir}.ssh/id_rsa"
    config.x.filepath_public_key = "#{config.x.base_dir}.ssh/id_rsa.pub"
  end
end
