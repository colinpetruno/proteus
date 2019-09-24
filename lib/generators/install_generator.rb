require 'rails/generators'
require 'rails/generators/migration'
require "rails/generators/active_record/migration"

module Proteus
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include ActiveRecord::Generators::Migration
      class_option :encryption_engine, type: :string, default: "none"

      source_root File.expand_path("templates", __dir__)
      desc "Add the migrations for Porteus"

      def copy_migrations
        # options["encryption_engine"]
        warn "Creating Migrations for Proteus Whitelabeling"
        migration_template(
          "create_proteus.rb.erb",
          "db/migrate/create_proteus.rb"
        )
      end

      def encryption_engine
        options["encryption_engine"]
      end

      def migration_version
        "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
      end
    end
  end
end
