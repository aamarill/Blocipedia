require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Blocipedia
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # This line below is what makes anything in "lib" accessible to all tests.
    # Note that "RandomData" module is within "lib" so RandomData becomes available to all tests.
    # Added by Adan Amarillas
    config.autoload_paths << File.join(config.root, "lib")
  end
end
