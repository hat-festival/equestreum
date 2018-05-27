require 'digest'

require 'equestreum/version'
require 'equestreum/block'

module Equestreum
  def self.hash nonce, difficulty, prev, data
    string = '%s%s%s%s' % [
      nonce,
      Time.now.to_i,
      '0' * difficulty,
      prev,
      data
    ]

    Digest::SHA256.hexdigest string
  end

  def self.difficulty_attained hash, difficulty
    hash.start_with? '0' * difficulty
  end
end
