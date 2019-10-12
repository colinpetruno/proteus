module Proteus
  class StylesheetCopier
    def self.for(domain)
      new(domain)
    end

    def initialize(domain)
      @domain = domain
    end

    def copy
      linked_stylesheets.each do |stylesheet_to_copy|
        puts "Iterating over each stylesheet"
        puts "copying #{stylesheet_to_copy}"
        puts "enabled: #{stylesheet_to_copy.value}"

        if stylesheet_to_copy.value == "true"
          copy_manifest(stylesheet_to_copy.key)
        else
          puts "Disabled manifest for #{stylesheet_to_copy.key}"
        end
      end
    end

    def copy!
    end

    private

    attr_accessor :domain

    def copy_manifest(manifest_file_name)
      original_manifest_path = stylesheet_path(manifest_file_name)

      if original_manifest_path.blank?
        raise ::Proteus::Error.new("Could not find original manifest to compile")
      end

      new_filename = proteus_manifest_name_for(
        original_manifest_path,
        manifest_file_name
      )

      # TODO: ensure that we don't do this if the file is otherwise the same
      # we might need to read the manifest, and hash it without the first line
      # and compare the hash to the original manifest. This will also need
      # to be done for the variables and perhaps track it into the database?

      File.open(new_filename, "w") do |fo|
        fo.puts "@import 'proteus_variables/#{domain.slug}.scss';";

        File.foreach(original_manifest_path) do |line|
          fo.puts line
        end
      end

      # Set up the variable file for this manifest
      #

      asset_directory = File.dirname(original_manifest_path)
      variable_directory = File.join(asset_directory, "proteus_variables")
      variable_file = File.join(variable_directory, "#{domain.slug}.scss")

      # ensure this exists if it does not
      Folders.create!(variable_directory)

      File.open(variable_file, "w") do |fo|
        domain.sass_properties.each do |property|
          fo.puts "$#{property.key}: #{property.value};"
        end
      end
    end

    # Linked stylesheets are required to generate the whitelabel asset. We need
    # to output each one of these manifests again but with a custom variable
    # file and name
    def linked_stylesheets
      domain.linked_stylesheet_properties
    end

    def asset_paths
      Rails.application.config.assets.paths
    end

    def proteus_manifest_name_for(original_path, manifest)
      # proteus_get_magnexus_application.scss
      new_filename = "proteus_#{domain.slug}_#{manifest}"

      original_path.gsub(manifest, new_filename)
    end

    def stylesheet_path(stylesheet_name)
      found = false

      # check main stylesheet folder
      manifest = find_manifest_in_path(
        Rails.root.join("app", "assets", "stylesheets").to_s,
        stylesheet_name
      )

      return manifest if manifest.present?

      for path in asset_paths do
        if found.blank?
          found = find_manifest_in_path(path, stylesheet_name)
        end
      end

      found
    end

    def find_manifest_in_path(path, stylesheet_name)
      files = Dir.glob("#{path}/*.{scss}")
      detected_files = files.grep(Regexp.new(stylesheet_name))

      if detected_files.present?
        return detected_files.first
      else
        return nil
      end
    end
  end
end
