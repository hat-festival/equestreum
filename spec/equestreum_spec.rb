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

    context 'regular block' do
      it 'verifies a regular block' do
        hash = '000ff21d2cc674291907aed5eac7ff9195a9bad961a2e69a5ef07ce2a45274ef'
        expect(Equestreum.difficulty_attained hash, difficulty: 3).to be true
      end
    end

    context ':horse block' do
      it 'verifies a :horse block' do
        hash = '1f40ea04bcaba76ec015e6626b417b61874562c7b35dc4e982f413a0b8c47336'
        expect(Equestreum.horse_attained hash).to be true
      end

      it 'verifies a more difficult :horse block' do
        hash = '1f40e064bcaba76ec015e6626b417b61874562c7b35dc4e982f413a0b8c47336'
        expect(Equestreum.horse_attained hash, difficulty: 6).to be true
      end

      it 'does not verify a :tiger block' do
        hash = '1f405a04bcaba76ec015e6626b417b61874562c7b35dc4e982f413a0b8c47336'
        expect(Equestreum.horse_attained hash).to be false
      end
    end

    context ':duck block' do
      it 'verifies a :duck block' do
        hash = '1f986a04bcaba76ec015e6626b417b61874562c7b35dc4e982f413a0b8c47336'
        expect(Equestreum.duck_attained hash).to be true
      end

      it 'verifies a more difficult :duck block' do
        hash = '1f986000bcaba76ec015e6626b417b61874562c7b35dc4e982f413a0b8c47336'
        expect(Equestreum.duck_attained hash, difficulty: 8).to be true
      end

      it 'does not verify a :llama block' do
        hash = '1f999a04bcaba76ec015e6626b417b61874562c7b35dc4e982f413a0b8c47336'
        expect(Equestreum.horse_attained hash).to be false
      end
    end
  end
end
