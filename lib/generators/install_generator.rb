require 'rails/generators'
require 'rails/generators/migration'
require "rails/generators/active_record/migration"

module Proteus
  module Generators
    class InstallGenerator < Rails::Generators::Base
      # include Rails::Generators::Migration
      include ActiveRecord::Generators::Migration
      source_root File.expand_path("templates", __dir__)
      desc "Add the migrations for Porteus"

      def copy_migrations
        warn "Creating Migrations for Proteus Whitelabeling"
        migration_template(
          "create_proteus.rb.erb",
          "db/migrate/create_proteus.rb",
          migration_version: migration_version
        )
      end

       def migration_version
         "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
       end
    end
  end
end
