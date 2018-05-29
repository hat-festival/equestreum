module Equestreum
  describe Chain do
    chain = Chain.new

    context 'serialisation' do
      before :each do
         allow(Config.instance.config).
          to receive(:[]).with('chain_path').and_return('tmp/equestreum.chain')
      end

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
