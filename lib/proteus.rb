# Core gem files
require "proteus/version"
require "proteus/engine"
require "proteus/configuration"

# Generators
require "generators/install_generator.rb"

module Proteus
  class Error < StandardError; end

  def self.configure
    @@configuration ||= ::Proteus::Configuration.new

    yield(@@configuration)
  end

  def self.configuration
    @@configuration ||= ::Proteus::Configuration.new
  end

  def self.table_name_prefix
    "proteus_"
  end
end
