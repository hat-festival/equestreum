module Equestreum
  class Block
    attr_accessor :data, :prev, :difficulty
    attr_reader :hash, :nonce, :time

    def initialize
      @difficulty = 4

      yield self if block_given?
    end

    def mine
      @time = Time.now.to_i
      @nonce = 0
      loop do
        @hash = Equestreum.hash @nonce, @time, @difficulty, @prev, @data
        if Equestreum.difficulty_attained hash, @difficulty
          break
        else
          @nonce += 1
        end
      end
    end

    def to_h
      h = {}
      [
        :data,
        :time,
        :hash,
        :prev,
        :nonce,
        :difficulty
      ].each do |key|
        h[key] = self.send(key)
      end
      h
    end
  end
end
