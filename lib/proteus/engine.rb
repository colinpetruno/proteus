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
      WhitelabeledDomain.all.each do |domain|
        puts "Adding domain to whitelabel list: #{domain.host}"

        # add the host to the whitelabeled host list for rails 6. The setting
        # is disabled when nil so we will want to keep that blank
        if app.config.respond_to?(:hosts) && !app.config.hosts.nil?
          app.config.hosts << domain.host
        end

        # add the manifest to the precompile list
        app.config.assets.precompile << "#{domain.slug}.css"
      end
    end

    initializer "proteus.view_helpers" do
      ActionView::Base.send :include, Proteus::Helpers
    end

    config.autoload_paths += Dir["#{config.root}/lib/**/"]
  end
end
