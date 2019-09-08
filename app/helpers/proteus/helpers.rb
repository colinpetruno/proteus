module Proteus
  module Helpers
    def proteus_stylesheet_link_tag(name, opts={})


      # TODO: we will need to inspect to ensure that the stylesheets and vars
      # aren't modified in development and if so copy them over. We should
      # probably hook into the compile_assets_fallback option or something



      domain = WhitelabeledDomain.find_by(host: request.host)

      if domain.present?
        whitelabel_stylesheet_name = "proteus_#{domain.slug}_#{name}"
        stylesheet_link_tag(whitelabel_stylesheet_name, opts)
      else
        stylesheet_link_tag(name, opts)
      end
      # this method eventually gets into
      # path_to_stylesheet(source, path_options)
      # in order to return the full path to the asset
      # source = name of manifest file
      # opts = path_options = options.extract!("protocol", "host", "skip_pipeline").symbolize_keys
      #
      # eventually this gets down to
      # path_to_asset(source, { type: :stylesheet }.merge!(options))
      #
      # this leads to this line
      # https://github.com/rails/rails/blob/96289cfb9b6aeb8f1a917f892148fd47f2f2049a/actionview/lib/action_view/helpers/asset_url_helper.rb#L186
      #
      #
      # and this gets us down to here
      #
      #
      #  if options[:skip_pipeline]
      #    source = public_compute_asset_path(source, options)
      #  else
      #    source = compute_asset_path(source, options)
      #  end
    rescue Sprockets::Rails::Helper::AssetNotFound => error

      # need to check if the domain is included in whitelabel domains based
      # upon the request
      if domain.present?
        StylesheetCopier.for(domain).copy

        whitelabel_stylesheet = "proteus_#{domain.slug}_#{name}"
        stylesheet_link_tag(name, opts)
      else
        raise error
      end
    end
  end
end




# exploring this instead, this is part of sprockets that provides the digestion
# Rails.application.assets.find_asset("application.css").digest_path
#
#
#
# Sprockets environment.load -> This load method does something interesting
