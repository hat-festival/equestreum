module Equestreum
  describe Config do


    it 'has a path' do
      @conf = Equestreum::Config.instance.config
      expect(@conf['chain_path']).to eq 'tmp/home/horse/.equestreum/equestreum.chain'
    end
  end
end
