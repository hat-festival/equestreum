RSpec.describe Equestreum do
  it 'generates a hash' do
    Timecop.freeze '1974-06-15' do
      nonce = 0
      difficulty = '00'
      prev = '000000000019d6689c085ae165831e934ff763ae46a2a6c172b3f1b60a8ce26f'
      data = 'equestreum'

      expect(Equestreum.hash nonce, difficulty, prev, data).to eq (
        'a1d05a04bcaba76ec015e6626b417b61874562c7b35dc4e982f413a0b8c47336'
      )
    end
  end
end
