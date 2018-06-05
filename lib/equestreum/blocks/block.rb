module Equestreum
  class Block
    attr_accessor :data, :previous_hash, :search_string, :search_width
    attr_reader :hash, :nonce, :time, :mined

    def initialize
      @search_string = '00000'
      @search_width = 8
      @mined = false

      yield self if block_given?
    end

    def mine
      @time = Time.now.to_i
      @nonce = 0
      loop do
        @hash = Hasher.hash @nonce, @search_string, @previous_hash, @data
        if Hasher.proven @hash, search_string: @search_string, search_width: @search_width
          @mined = true
          break
        else
          @nonce += 1
        end
      end
    end
  end
end
