require 'digest'
require 'singleton'
require 'yaml'

require 'equestreum/version'
require 'equestreum/config'
require 'equestreum/block'
require 'equestreum/chain'

module Equestreum
  def self.hash nonce, time, difficulty, prev, data
    string = '%s%s%s%s%s' % [
      nonce,
      time,
      '0' * difficulty,
      prev,
      data
    ]

    Digest::SHA256.hexdigest string
  end

  def self.difficulty_attained hash, difficulty
    hash.start_with? '0' * difficulty
  end

  class EquestreumException < Exception
    attr_reader :text

    def initialize text
      @text = text
    end
  end
end
