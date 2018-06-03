module Equestreum
  describe DuckBlock do
    context 'proof-of-work' do
      it 'verifies at default difficulty' do
        hash = '1f986a04bcaba76ec015e6626b417b61874562c7b35dc4e982f413a0b8c47336'
        expect(described_class.difficulty_attained hash).to be true
      end

      it 'verifies at higher difficulty' do
        hash = '1f986000bcaba76ec015e6626b417b61874562c7b35dc4e982f413a0b8c47336'
        expect(described_class.difficulty_attained hash, difficulty: 8).to be true
      end

      it 'does not verify a :llama block' do
        hash = '1f999a04bcaba76ec015e6626b417b61874562c7b35dc4e982f413a0b8c47336'
        expect(described_class.difficulty_attained hash).to be false
      end
    end

    it 'mines itself' do
      db = DuckBlock.new do |b|
        b.prev = '00005a04bcaba76ec015e6626b417b61874562c7b35dc4e982f413a0b8c47336'
      end

      Timecop.freeze EPOCH do
        db.mine
      end

      expect(db.hash).to eq '1f9864df44d4aee8ef959dd206cdca4a725739bc83eeb8ebbde0d1b57e6d391b'
      expect(db.nonce).to eq 199421
      expect(db.time).to eq 140486400
    end
  end
end
