module Proteus
  class Configuration
    attr_accessor :layout, :encryption_engine, :image_storage_engine

    def initialize
      @attribute = "donotreply@example.com"
      @layout = "proteus_web"
      @image_storage_engine = "none"
    end
  end
end
