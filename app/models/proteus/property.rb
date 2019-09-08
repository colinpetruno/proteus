module Proteus
  class Property < ActiveRecord::Base
    belongs_to(
      :whitelabeled_domain,
      foreign_key: :proteus_white_labeled_domain_id,
      class_name: "Proteus::WhitelabeledDomain"
    )
  end
end
