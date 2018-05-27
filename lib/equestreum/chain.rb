module Equestreum
  class Chain < Array
    def initialize genesis
      self.push genesis
    end
  end
end
