module Proteus
  class Configuration
    attr_accessor :layout, :encryption_engine

    def initialize
      @attribute = "donotreply@example.com"
      @layout = "proteus_web"
    end
  end
end
