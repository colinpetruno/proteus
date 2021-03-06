module Proteus
  class WhitelabeledDomainsController < ::Proteus::ApplicationController
    def edit
      @whitelabeled_domain = WhitelabeledDomain.find(params[:id])
    end

    def index
      @whitelabeled_domains = WhitelabeledDomain.all
    end

    def new
      @whitelabeled_domain = WhitelabeledDomain.new
    end

    def create
      @whitelabeled_domain = WhitelabeledDomain.new(whitelabeled_domain_params)

      if @whitelabeled_domain.save
        redirect_to whitelabeled_domains_path
      else
        render :new
      end
    end

    def update
      @whitelabeled_domain = WhitelabeledDomain.find(params[:id])

      if @whitelabeled_domain.update(whitelabeled_domain_params)
        redirect_to edit_whitelabeled_domain_path(@whitelabeled_domain)
      else
        render :edite
      end
    end

    private

    def whitelabeled_domain_params
      params.
        require(:whitelabeled_domain).
        permit(:host, :slug, :compile, :enabled, :root_path)
    end
  end
end
