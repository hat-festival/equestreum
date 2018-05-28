module Equestreum
  describe Config do
    before :each do
      @conf = Equestreum::Config.instance.config
    end

    it 'has a path' do
      expect(@conf['chain_path']).to eq 'tmp/equestreum.chain'
    end
  end
end
