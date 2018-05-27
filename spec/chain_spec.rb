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
        Timecop.freeze '1974-06-16' do
          chain.grow 'exodus'
        end
        expect(chain.length).to eq 2
        expect(chain.last.hash).to eq '000249da357db436f9b0c5cdade30e41d80093ea6d0510fe7d276b8dc8024889'
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
        expect(chain[3].nonce).to eq 10466
      end
    end

    context 'verify itself' do

    end
  end
end
