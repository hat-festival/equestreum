module Equestreum
  class Hasher
    def self.proven hash, string:, space: 0
      space = string.length if space < string.length
      hash[0..space - 1].include? string
    end

    def self.hash nonce, difficulty, previous, data
      string = '%s%s%s%s%s' % [
        nonce,
        Time.now.to_i,
        difficulty,
        previous,
        data
      ]

      Digest::SHA256.hexdigest string
    end
  end
end
