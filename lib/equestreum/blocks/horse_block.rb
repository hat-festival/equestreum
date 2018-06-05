module Equestreum
  class HorseBlock < Block
    def initialize
      super
      @search_string = Config.instance.config['horse']
    end
  end
end
