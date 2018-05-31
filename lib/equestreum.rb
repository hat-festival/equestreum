require 'digest'
require 'singleton'
require 'yaml'

require 'equestreum/version'
require 'equestreum/config'
require 'equestreum/block'
require 'equestreum/chain'

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

  def self.horse_attained hash, difficulty: 5
    self.difficulty_attained hash, type: :horse, difficulty: difficulty
  end

  def self.duck_attained hash, difficulty: 5
    self.difficulty_attained hash, type: :duck, difficulty: difficulty
  end

  def self.difficulty_attained hash, type: :regular, difficulty: 5
    types = {
      horse: '1f40e',
      duck: '1f986'
    }
    lead = '0' * difficulty
    if types[type]
      lead = self.lead_string types[type], difficulty: difficulty
    end

    hash.start_with? lead
  end

  class EquestreumException < Exception
    attr_reader :text

    def initialize text
      @text = text
    end
  end
end
