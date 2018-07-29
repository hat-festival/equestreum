module Equestreum
  describe Chain do
    before :each do
      allow(Config.instance.config).
        to receive(:[]).with('chain_path').and_return('tmp/chain/equestreum.chain')
      allow(Config.instance.config).
        to receive(:[]).with('difficulty').and_call_original
    end

    it 'complains if we try to revive a non-existent chain' do
      expect { Chain.revive }.to raise_exception do |ex|
        expect(ex).to be_an EquestreumException
        expect(ex.text).to match /no chain found at/
      end
    end

    it 'makes a new chain if no saved one exists' do
      Timecop.freeze '1980-01-01' do
        Chain.init
      end
      expect(File).to exist 'tmp/chain/equestreum.chain'
      c = Chain.revive
      expect(c.first.time).to eq 315532800
    end

    it "doesn't overwrite an existing chain" do
      Timecop.freeze '1980-01-01' do
        c = Chain.new
        c.save
      end

      c = Chain.init
      expect(File).to exist 'tmp/chain/equestreum.chain'
      c = Chain.revive
      expect(c.first.time).to eq 315532800
    end

    it 'takes a difficulty' do
      FileUtils.rm_r Config.instance.config['chain_path']
      Chain.init difficulty: 2
      expect(Chain.revive[0].difficulty).to eq 2
    end

    it 'reads the difficulty from the config' do
      FileUtils.rm_r Config.instance.config['chain_path']
      allow(Config.instance.config).
        to receive(:[]).with('difficulty').and_return(1)
      Chain.init
      expect(Chain.revive[0].difficulty).to eq 1
    end
  end
end
