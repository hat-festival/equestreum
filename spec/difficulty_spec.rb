module Equestreum
  describe Chain do
    genesis = Block.new do |b|
      b.data = 'genesis block'
      b.prev = '0000000000000000000000000000000000000000000000000000000000000000'
      b.difficulty = 2
    end

    Timecop.freeze '1974-06-15' do
      genesis.mine
    end

    chain = Chain.new genesis

    Timecop.freeze '1974-06-17' do
      chain.grow 'revelation', difficulty: 3
    end

    context 'difficulty' do
      it 'can change the difficulty' do
        expect(chain[0].difficulty).to eq 2
        expect(chain[1].difficulty).to eq 3
      end
    end
  end
end
