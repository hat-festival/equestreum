module Equestreum
  class Chain < Array
    private :push, :append, :<<
    attr_accessor :seed_data, :seed_search_string, :seed_search_width

    def initialize
      @seed_data = 'genesis block'
      @seed_search_string = '000'

      yield self if block_given?

      grow @seed_data,
           seed_search_string: @seed_search_string,
           seed_search_width: @seed_search_width,
           previous_hash: '0000000000000000000000000000000000000000000000000000000000000000'
    end

    def grow data, difficulty: nil, prev: nil
      block = Block.new do |b|
        b.data = data
        b.prev = prev ? prev : self.last.hash
        b.difficulty = difficulty ? difficulty : self.last.difficulty
      end

      block.mine
      push block
    end

    def self.grow data, difficulty: nil
      chain = self.revive
      chain.grow data, difficulty: difficulty
      chain.save

      chain
    end

    def data with_genesis: false
      data = self.map do |b|
        {
          datetime: Time.at(b.time).iso8601,
          data: b.data
        }
      end

      data.shift unless with_genesis

      data
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

    def previous_hash_ok? index
      return true if index == 0
      block = self[index]
      previous = self[index - 1]
      block.prev == previous.hash
    end

    def previous_hashes_ok?
      self.length.times do |index|
        raise EquestreumException.new "Hash chain broken in block at #{index}" unless previous_hash_ok? index
      end
      true
    end

    def newer_than_last? index
      return true if index == 0
      block = self[index]
      previous = self[index - 1]
      block.time > previous.time
    end

    def blocks_get_newer?
      self.length.times do |index|
        raise EquestreumException.new "Block at #{index} seems older than its predecessor" unless newer_than_last? index
      end
      true
    end

    def verified?
      hashes_ok? && proofs_of_work_ok? && previous_hashes_ok? && blocks_get_newer?
    end

    def save
      File.open Config.instance.config['chain_path'], 'w' do |f|
        f.write Marshal.dump self
      end
    end

    def self.revive
      Marshal.load File.read Config.instance.config['chain_path']
    end
  end
end
