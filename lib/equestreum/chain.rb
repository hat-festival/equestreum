module Equestreum
  class Chain < Array
    def initialize genesis
      self.push genesis
    end

    def grow data
      block = Block.new do |b|
        b.data = data
        b.prev = self.last.hash
        b.difficulty = self.last.difficulty
      end

      block.mine

      self.push block
    end
  end
end
