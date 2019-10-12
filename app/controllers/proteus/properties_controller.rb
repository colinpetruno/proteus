module Proteus
  class PropertiesController < ::Proteus::ApplicationController
    def create
      domain = WhitelabeledDomain.find(params[:whitelabeled_domain_id])
      @property = domain.properties.build(property_params)

      if @property.save
        redirect_to edit_whitelabeled_domain_path(domain)
      end
    end

    def destroy
      domain = WhitelabeledDomain.find(params[:whitelabeled_domain_id])
      @property = domain.properties.find(params[:id])

      if @property.destroy
        redirect_to edit_whitelabeled_domain_path(domain)
      end
    end

    def update
      domain = WhitelabeledDomain.find(params[:whitelabeled_domain_id])
      @property = domain.properties.find(params[:id])

      if @property.update(property_params)
        StylesheetCopier.for(domain).copy
        redirect_to edit_whitelabeled_domain_path(domain)
      end
    end

    private

    def property_params
      params.require(:property).permit(:id, :type, :key, :value, :asset)
    end
  end
end
