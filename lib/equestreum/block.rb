module Equestreum
  class Block
    attr_accessor :data, :prev, :difficulty
    attr_reader :hash, :nonce, :time

    def initialize
      @difficulty = '0000'

      yield self if block_given?
    end
  end
end
