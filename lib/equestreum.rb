require 'digest'

require 'equestreum/version'

module Equestreum
  def self.hash nonce, difficulty, prev, data
    string = '%s%s%s%s' % [
      nonce,
      Time.now.to_i,
      difficulty,
      prev,
      data
    ]

    Digest::SHA256.hexdigest string
  end
end
