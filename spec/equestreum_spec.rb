describe Equestreum do
  context 'hashing' do
    it 'generates a hash with a string difficulty' do
      Timecop.freeze EPOCH do
        nonce = 0
        difficulty = '00'
        prev = '000000000019d6689c085ae165831e934ff763ae46a2a6c172b3f1b60a8ce26f'
        data = 'equestreum'

        expect(Equestreum.hash nonce, difficulty, prev, data).to eq (
          '073ec7c3e479cf0299a55a05d100cce1262477a9b144bf1484bffc3f92f78fc6'
        )
      end
    end

    it 'generates a hash with an integer difficulty' do
      Timecop.freeze EPOCH do
        nonce = 0
        difficulty = 3
        prev = '000000000019d6689c085ae165831e934ff763ae46a2a6c172b3f1b60a8ce26f'
        data = 'equestreum'

        expect(Equestreum.hash nonce, difficulty, prev, data).to eq (
          '4ae8dc1affe9291ae7afde5878dd1ffd76f0c5dfd9c6230750dfac6820c092ac'
        )
      end
    end
  end

  context 'verify proof-of-work' do
    context 'lead string' do
      it 'generates a default lead string' do
        expect(Equestreum.lead_string '1f40e').to eq '1f40e'
      end

      it 'handles a short difficulty' do
        expect(Equestreum.lead_string '1f40e', difficulty: 5).to eq '1f40e'
      end

      it 'handles a longer difficulty' do
        expect(Equestreum.lead_string '1f40e', difficulty: 7).to eq '1f40e00'
      end
    end
  end
end
