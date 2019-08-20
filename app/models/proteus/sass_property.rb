module Proteus
  class SassProperty < Property
    belongs_to(
      :whitelabeled_domain,
      class_name: "Proteus::WhitelabeledDomain",
      foreign_key: :proteus_white_labeled_domain_id
    )

    def self.model_name
      Proteus::Property.model_name
    end

    def white_labeled_domain
      proteus_white_labeled_domain
    end
  end
end
