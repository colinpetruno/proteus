module Proteus
  class WhitelabeledDomain < ActiveRecord::Base
    has_many(
      :properties,
      foreign_key: :proteus_white_labeled_domain_id
    )

    has_many(
      :app_properties,
      foreign_key: :proteus_white_labeled_domain_id
    )

    has_many(
      :sass_properties,
      foreign_key: :proteus_white_labeled_domain_id
    )

    has_many(
      :linked_stylesheet_properties,
      foreign_key: :proteus_white_labeled_domain_id
    )
  end
end
