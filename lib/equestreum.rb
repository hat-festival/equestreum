require 'digest'
require 'singleton'
require 'yaml'

require 'equestreum/version'
require 'equestreum/config'
require 'equestreum/blocks/block'
require 'equestreum/blocks/duck_block'
require 'equestreum/blocks/horse_block'
require 'equestreum/chain'
require 'equestreum/hasher'

module Equestreum
  def self.hash nonce, difficulty, prev, data
    if difficulty.class == Integer
      difficulty = '0' * difficulty
    end

    string = '%s%s%s%s%s' % [
      nonce,
      Time.now.to_i,
      difficulty,
      prev,
      data
    ]

    Digest::SHA256.hexdigest string
  end

  def self.lead_string string, difficulty: 5
    zeroes = ''
    offset = difficulty - string.length
    if offset > 0
      zeroes = '0' * offset
    end

    '%s%s' % [string, zeroes]
  end

  class EquestreumException < Exception
    attr_reader :text

    def initialize text
      @text = text
    end
  end
end
