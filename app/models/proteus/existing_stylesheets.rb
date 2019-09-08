module Proteus
  class ExistingStylesheets
    def self.find
      new.find_application
    end

    def self.application_options
      new.application_options
    end

    def find_all
      Rails.application.config.assets.paths.map do |path|
        Dir.glob("#{path}/*.{scss}")
      end.flatten
    end

    def find_application
      Dir.glob("#{stylesheet_directory.to_s}/*.{scss}")
    end

    def application_options
      find_application.map do |file|
        File.basename(file)
      end
    end

    private

    def stylesheet_directory
      # TODO: Grab the rails settings for the assets directory
      Rails.root.join("app", "assets", "stylesheets")
    end
  end
end
