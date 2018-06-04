module Equestreum
  class Hasher
    def self.proven hash, search_string:, search_width: 0
      search_width = search_string.length if search_width < search_string.length
      hash[0..search_width - 1].include? search_string
    end

    def self.hash nonce, search_string, previous_hash, data
      string = '%s%s%s%s%s' % [
        nonce,
        Time.now.to_i,
        search_string,
        previous_hash,
        data
      ]

      Digest::SHA256.hexdigest string
    end
  end
end
