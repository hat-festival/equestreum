describe Equestreum do
  it 'generates a hash' do
    nonce = 0
    time = Time.at(EPOCH).to_i
    difficulty = 2
    prev = '000000000019d6689c085ae165831e934ff763ae46a2a6c172b3f1b60a8ce26f'
    data = 'equestreum'

    expect(Equestreum.hash nonce, time, difficulty, prev, data).to eq (
      '073ec7c3e479cf0299a55a05d100cce1262477a9b144bf1484bffc3f92f78fc6'
    )
  end

  it 'verifies proof-of-work' do
    hash = '00005a04bcaba76ec015e6626b417b61874562c7b35dc4e982f413a0b8c47336'
    expect(Equestreum.difficulty_attained hash, 4).to be true
    expect(Equestreum.difficulty_attained hash, 6).to be false
  end
end
