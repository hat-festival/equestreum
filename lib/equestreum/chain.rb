module Equestreum
  class Chain < Array
    private :push, :append, :<<
    attr_accessor :genesis_data, :difficulty, :path

    def initialize
      @genesis_data = 'genesis block'
      @difficulty = 3
      @path = Config.instance.config['chain_path']
      yield self if block_given?

      grow @genesis_data,
        prev: '0000000000000000000000000000000000000000000000000000000000000000'
    end

    def path= path
      Config.instance.config['chain_path'] = path
    end

    def self.difficulty= diff
      c = self.revive
      c.difficulty = diff
      c.save
    end

    def self.difficulty
      self.revive.difficulty
    end

    def self.init difficulty: 3
      diff = Config.instance.config['difficulty'] ? Config.instance.config['difficulty'] : difficulty
      unless File.exists? Config.instance.config['chain_path']
        chain = Chain.new do |c|
          c.difficulty = diff
        end
        chain.save
      end
    end

    def grow data, prev: nil
      block = Block.new do |b|
        b.data = data
        b.prev = prev ? prev : self.last.hash
        b.difficulty = @difficulty
      end

      block.mine
      push block
    end

    def self.grow data
      chain = self.revive
      chain.grow data
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

    def self.aggregate
      h = Hash.new 0
      Chain.revive[1..-1].each do |block|
        h[block.data] += 1
      end
      h
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
        unless hash_ok? index
          raise EquestreumException.new "Block at #{index} tampered with"
        end
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
      block.time >= previous.time
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
      FileUtils.mkdir_p File.dirname Config.instance.config['chain_path']
      File.open Config.instance.config['chain_path'], 'w' do |f|
        f.write Marshal.dump self
      end
    end

    def self.revive
      begin
        Marshal.load File.read Config.instance.config['chain_path']
      rescue Errno::ENOENT
        raise EquestreumException.new "no chain found at #{Config.instance.config['chain_path']}"
      end
    end
  end
end
