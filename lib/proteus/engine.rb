require "active_record"
require "rails/engine"

require "proteus"

module Proteus
  class Engine < ::Rails::Engine
    isolate_namespace ::Proteus

    initializer "proteus_web.assets.precompile" do |app|
      app.config.assets.precompile += %w(proteus/proteus_web.scss)
    end

    initializer "proteus_web.setup_hosts" do |app|
      if ActiveRecord::Base.connection.data_source_exists?("proteus_whitelabeled_domains")
        domains = WhitelabeledDomain.all
      else
        domains = []
      end

      domains.each do |local_domain|
        # Ensure latest manifest files before compilation
        StylesheetCopier.for(local_domain).copy

        # Add the host to the whitelabeled host list for rails 6. The setting
        # is disabled when nil, so we will want to keep that blank if it is
        # already blank
        if app.config.respond_to?(:hosts) && !app.config.hosts.nil?
          app.config.hosts << domain.host
        end

        # for each linked manifest file for this domain, we need to then go
        # and add the adjusted Proteus stylesheet name to the precompiled asset
        # list to prevent errors down the road
        local_domain.linked_stylesheet_properties.each do |property|
          if property.value == "true"
            asset_name = "proteus_#{domain.slug}_#{property.key}"
            app.config.assets.precompile << asset_name
          end
        end
      end
    end

    initializer "proteus.view_helpers" do
      ActionView::Base.send :include, Proteus::Helpers
    end

    config.autoload_paths += Dir["#{config.root}/lib/**/"]
  end
end
