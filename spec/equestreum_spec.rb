describe Equestreum do
  it 'generates a hash' do
    Timecop.freeze '1974-06-15' do
      nonce = 0
      difficulty = 2
      prev = '000000000019d6689c085ae165831e934ff763ae46a2a6c172b3f1b60a8ce26f'
      data = 'equestreum'

      expect(Equestreum.hash nonce, difficulty, prev, data).to eq (
        'a19b51472e111d39e0d97848dd2d6c6ac328176ac68f0a4825a99ac455d2b552'
      )
    end
  end

  it 'verifies proof-of-work' do
    hash = '00005a04bcaba76ec015e6626b417b61874562c7b35dc4e982f413a0b8c47336'
    expect(Equestreum.difficulty_attained hash, 4).to be true
    expect(Equestreum.difficulty_attained hash, 6).to be false
  end
end
