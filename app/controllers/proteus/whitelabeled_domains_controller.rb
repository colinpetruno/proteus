module Proteus
  class WhitelabeledDomainsController < ApplicationController
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

    private

    def whitelabeled_domain_params
      params.
        require(:whitelabeled_domain).
        permit(:host, :slug, :compile, :enabled)
    end
  end
end
