module Proteus
  class AppProperty < Property
    belongs_to :whitelabeled_domain, foreign_key: :proteus_white_labeled_domain_id

    if Proteus.configuration.encryption_engine&.to_s&.downcase == "portunus"
      include Encryptable
      encrypted_fields :value
    end

    def self.model_name
      Proteus::Property.model_name
    end
  end
end
