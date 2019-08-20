module Proteus
  module Helpers
    def proteus_stylesheet_link_tag(name, opts={})
      stylesheet_link_tag(name, opts)
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
      domain = WhitelabeledDomain.where(host: request.host)
      # need to check if the domain is included in whitelabel domains based
      # upon the request
      if domain.present?
        # here we need to do a lot of shit

        # sprockets = Sprockets::Rails::Task.new(Rails.application)
        # get the link to the right stylesheet for now
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
