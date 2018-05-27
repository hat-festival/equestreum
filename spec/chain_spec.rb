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
      expect(chain.first.hash).to eq '000f1de8fa58156748d6b36408c7024f41e02cde553f630ee603e318223a19cb'
    end

    context 'extend itself' do
      it 'adds a block' do
        Timecop.freeze '1974-06-15' do
          chain.grow 'exodus'
        end
        expect(chain.length).to eq 2
        expect(chain.last.hash).to eq '0000913d07862643d3656a3dfa52318bbef4b1a770d0be8e01c93630ae232654'
      end

      it 'adds several blocks' do
        Timecop.freeze '1974-06-15' do
          chain.grow 'leviticus'
          chain.grow 'numbers'
          chain.grow 'deuteronomy'
        end

        expect(chain.length).to eq 5
        expect(chain[3].data).to eq 'numbers'
        expect(chain[3].nonce).to eq 906
      end
    end
  end
end
