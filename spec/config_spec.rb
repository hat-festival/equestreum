module Equestreum
  describe Config do
    it 'has a path' do
      fixture_yaml = YAML.load_file 'spec/fixtures/config.yaml'
      allow(YAML).to receive(:load_file).and_call_original
      allow(YAML).to receive(:load_file).
        with("#{ENV['HOME']}/.equestreum/config.yaml").and_return(fixture_yaml)
      @conf = Equestreum::Config.instance.config
      expect(@conf['chain_path']).to eq '/home/horse/.equestreum/equestreum.chain'
    end
  end
end
