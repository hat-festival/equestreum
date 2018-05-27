module Equestreum
  describe Chain do
    genesis = Block.new do |b|
      b.data = 'genesis block'
      b.prev = '0000000000000000000000000000000000000000000000000000000000000000'
      b.difficulty = 3
    end

    chain = Chain.new genesis

    it 'has the genesis block' do
      expect(chain.first).to eq genesis
      expect(chain.length).to eq 1
    end
  end
end
