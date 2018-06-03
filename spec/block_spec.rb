module Equestreum
  describe Block do
    context 'constructor' do
      it 'takes arguments' do
        block = Block.new do |b|
          b.data = 'equestreum'
          b.prev = '00005a04bcaba76ec015e6626b417b61874562c7b35dc4e982f413a0b8c47336'
          b.difficulty = 2
        end

        expect(block.data).to eq 'equestreum'
      end

      it 'has default difficulty' do
        block = Block.new do |b|
          b.data = 'equestreum'
          b.prev = '00005a04bcaba76ec015e6626b417b61874562c7b35dc4e982f413a0b8c47336'
        end

        expect(block.difficulty).to eq 4
      end
    end

    it 'verifies proof-of-work' do
      hash = '000ff21d2cc674291907aed5eac7ff9195a9bad961a2e69a5ef07ce2a45274ef'
      expect(described_class.difficulty_attained hash).to be true
    end

    it 'mines itself' do
      block = Block.new do |b|
        b.data = 'equestreum'
        b.prev = '00005a04bcaba76ec015e6626b417b61874562c7b35dc4e982f413a0b8c47336'
        b.difficulty = 1
      end

      Timecop.freeze EPOCH do
        block.mine
      end

      expect(block.hash).to eq '08e89c6eb23ab500171403ea56a446d6258eede05023f91af9585f140ce63491'
      expect(block.nonce).to eq 1
      expect(block.data).to eq 'equestreum'
      expect(block.time).to eq 140486400
    end
  end
end
