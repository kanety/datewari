require_relative 'boot'

require "active_record/railtie"
require "active_job/railtie"
require "action_controller/railtie"
require "action_view/railtie"

Bundler.require(*Rails.groups)
require "datewari"

module Dummy
  class Application < Rails::Application
    config.load_defaults Rails::VERSION::STRING.to_f if config.respond_to?(:load_defaults)

    unless (database = ENV['DATABASE'].to_s).empty?
      config.paths["config/database"] = "config/database_#{database}.yml"
      ENV['SCHEMA'] = Rails.root.join("db/schema_#{database}.rb").to_s
    end
  end
end
