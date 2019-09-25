# Core gem files
require "proteus/version"
require "proteus/engine"
require "proteus/configuration"

# Generators
require "generators/install_generator.rb"

module Proteus
  class Error < StandardError; end

  class << self
    attr_writer :configuration
  end

  def self.configure
    self.configuration = @@configuration || ::Proteus::Configuration.new
    yield(configuration)
  end

  def self.configuration
    @@configuration ||= self.configure
  end

  def self.table_name_prefix
    "proteus_"
  end
end
