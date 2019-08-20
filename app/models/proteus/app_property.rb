module Proteus
  class AppProperty < Property
    belongs_to :whitelabeled_domain, foreign_key: :proteus_white_labeled_domain_id

    def self.model_name
      Proteus::Property.model_name
    end
  end
end
