module Equestreum
  describe HorseBlock do
    context 'proof-of-work' do
      it 'verifies at default difficulty' do
        hash = '1f40ea04bcaba76ec015e6626b417b61874562c7b35dc4e982f413a0b8c47336'
        expect(described_class.difficulty_attained hash).to be true
      end

      it 'verifies at higher difficulty' do
        hash = '1f40e064bcaba76ec015e6626b417b61874562c7b35dc4e982f413a0b8c47336'
        expect(described_class.difficulty_attained hash, difficulty: 6).to be true
      end

      it 'does not verify a :tiger block' do
        hash = '1f405a04bcaba76ec015e6626b417b61874562c7b35dc4e982f413a0b8c47336'
        expect(described_class.difficulty_attained hash).to be false
      end
    end

    it 'mines itself' do
      hb = HorseBlock.new do |b|
        b.prev = '00005a04bcaba76ec015e6626b417b61874562c7b35dc4e982f413a0b8c47336'
      end

      Timecop.freeze EPOCH do
        hb.mine
      end

      expect(hb.hash).to eq '1f40e64db1f192cca9c841bd5d9f449f2c3529a9cc909204125a8a14ee052aea'
      expect(hb.nonce).to eq 749227
      expect(hb.time).to eq 140486400
    end
  end
end
