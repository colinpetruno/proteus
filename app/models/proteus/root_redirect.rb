module Proteus
  class RootRedirect
    def self.for(request)
      new(request)
    end

    def initialize(request)
      @request = request
    end

    def redirect?
      domain.present? && domain.root_path.present?
    end

    def redirect_path
      if valid_path?
        Rails.application.routes.url_helpers.send(domain.root_path.to_sym)
      else
        Rails.application.routes.url_helpers.root_path
      end
    end

    private

    attr_reader :request

    def valid_path?
      valid_path_helpers.include?(domain.root_path)
    end

    def valid_path_helpers
      @_valid_path_helpers ||= Rails.
        application.
        routes.
        named_routes.
        helper_names
    end

    def domain
      @_domain ||= WhitelabeledDomain.find_by(host: request.host)
    end
  end
end
