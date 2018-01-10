require_relative 'boot'

require "rails/all"

Bundler.require(*Rails.groups)
require "datewari"

module Dummy
  class Application < Rails::Application
    unless (database = ENV['DATABASE'].to_s).empty?
      config.paths["config/database"] = "config/database_#{database}.yml"
      ENV['SCHEMA'] = Rails.root.join("db/schema_#{database}.rb").to_s
    end
  end
end
