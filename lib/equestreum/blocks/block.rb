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
        @hash = Equestreum.hash @nonce, @difficulty, @prev, @data
        if self.class.difficulty_attained hash, difficulty: @difficulty
          break
        else
          @nonce += 1
        end
      end
    end

    def self.difficulty_attained hash, difficulty: 3
      hash.start_with? '0' * difficulty
    end
  end
end
