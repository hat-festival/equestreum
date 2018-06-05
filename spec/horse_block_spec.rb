module Equestreum
  describe HorseBlock do
    it 'mines itself' do
      hb = HorseBlock.new do |b|
        b.previous_hash = '00005a04bcaba76ec015e6626b417b61874562c7b35dc4e982f413a0b8c47336'
      end

      Timecop.freeze EPOCH do
        hb.mine
      end

      expect(hb.hash).to eq '5d81f40ebe417275bb301973c9e93b34071362d1eb28b9865e840274aef750eb'
      expect(hb.nonce).to eq 35312
      expect(hb.time).to eq 140486400
    end
  end
end
