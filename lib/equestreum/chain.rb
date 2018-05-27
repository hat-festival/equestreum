module Equestreum
  class Chain < Array
    def initialize genesis
      self.push genesis
    end

    def grow data
      block = Block.new do |b|
        b.data = data
        b.prev = self.last.hash
        b.difficulty = self.last.difficulty
      end

      block.mine

      self.push block
    end

    def hash_ok? index
      block = self[index]

      block.hash == (Digest::SHA256.hexdigest '%s%s%s%s%s' % [
        block.nonce,
        block.time,
        '0' * block.difficulty,
        block.prev,
        block.data
      ])
    end

    def hashes_ok?
      self.length.times do |index|
        raise EquestreumException.new "Block at #{index} tampered with" unless hash_ok? index
      end
      true
    end

    def proof_of_work_ok? index
      block = self[index]
      block.hash.start_with? '0' * block.difficulty
    end

    def proofs_of_work_ok?
      self.length.times do |index|
        raise EquestreumException.new "Inconsistent difficulty in block at #{index}" unless proof_of_work_ok? index
      end
      true
    end
  end
end
