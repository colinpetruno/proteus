module Proteus
  class Configuration
    attr_accessor :layout

    def initialize
      @attribute = "donotreply@example.com"
      @layout = "proteus_web"
    end
  end
end
