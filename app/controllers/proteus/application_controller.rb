module Proteus
  class ApplicationController < ActionController::Base
    layout :proteus_layout

    private

    def proteus_layout
      ::Proteus.configuration.layout
    end
  end
end
