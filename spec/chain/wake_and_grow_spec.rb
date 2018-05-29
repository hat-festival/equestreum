module Equestreum
  describe Chain do
    before :each do
      allow(Config.instance.config).
        to receive(:[]).with('chain_path').and_return('tmp/equestreum.chain')
      starter_chain = test_chain 4
      starter_chain.save
    end

    context 'resting chain' do
      it 'can be woken up and grown' do
        Chain.grow 'hello blockchain'
        loaded_chain = Chain.revive
        expect(loaded_chain.length).to eq 5
        expect(loaded_chain[-1].data).to eq 'hello blockchain'
      end
    end
  end
end
