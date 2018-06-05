module Equestreum
  class DuckBlock < Block
    def initialize
      super
      @search_string = Config.instance.config['duck']
    end
  end
end
