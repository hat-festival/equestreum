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

    context 'serialisation' do
      it 'can serialise itself' do
        chain.save
        expect(File).to exist 'tmp/equestreum.chain'
      end

      it 'can be loaded' do
        saved_chain = Chain.revive
        expect(saved_chain).to be_a Chain
        expect(saved_chain[0].data).to eq 'genesis block'
      end
    end
  end
end
