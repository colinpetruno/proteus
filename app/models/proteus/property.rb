module Proteus
  class Property < ActiveRecord::Base
    if Proteus.configuration.encryption_engine&.to_s&.downcase == "portunus" &&
        ActiveRecord::Base.connection.data_source_exists?("proteus_whitelabeled_domains")
      include Encryptable
      encrypted_fields :value
    end

    belongs_to(
      :whitelabeled_domain,
      foreign_key: :proteus_white_labeled_domain_id,
      class_name: "Proteus::WhitelabeledDomain"
    )
  end
end
