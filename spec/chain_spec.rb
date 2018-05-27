module Equestreum
  describe Chain do
    genesis = Block.new do |b|
      b.data = 'genesis block'
      b.prev = '0000000000000000000000000000000000000000000000000000000000000000'
      b.difficulty = 3
    end

    Timecop.freeze '1974-06-15' do
      genesis.mine
    end

    chain = Chain.new genesis

    it 'has the genesis block' do
      expect(chain.length).to eq 1
      expect(chain.first).to eq genesis
      expect(chain.first.hash).to eq '000bc00e91fd08af44d6f0e82c74041397e1e46c5433d733d57f0a9e6dc2e344'
    end

    context 'extend itself' do
      it 'adds a block' do
        Timecop.freeze '1974-06-16' do
          chain.grow 'exodus'
        end
        expect(chain.length).to eq 2
        expect(chain.last.hash).to eq '0008dea44fb4c3260a1debd555ccfe012796ef46c725a015da78d9449769fb95'
      end

      it 'adds several blocks' do
        Timecop.freeze '1974-06-17' do
          chain.grow 'leviticus'
        end

        Timecop.freeze '1974-06-18' do
          chain.grow 'numbers'
        end

        Timecop.freeze '1974-06-19' do
          chain.grow 'deuteronomy'
        end

        expect(chain.length).to eq 5
        expect(chain[3].data).to eq 'numbers'
        expect(chain[3].nonce).to eq 1175
      end
    end

    context 'verify itself' do
      context 'hashes are kosher' do
        it 'verifies the hash of a block' do
          expect(chain.hash_ok? 2).to be true
        end

        it 'verifies all its hashes' do
          expect(chain.hashes_ok?).to be true
        end

        it 'knows when a block has been tampered with' do
          chain[1].data = 'Joshua'
          expect(chain.hashes_ok?).to be false
        end
      end
    end
  end
end
