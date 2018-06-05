module Equestreum
  describe DuckBlock do
    it 'mines itself' do
      db = DuckBlock.new do |b|
        b.previous_hash = '00005a04bcaba76ec015e6626b417b61874562c7b35dc4e982f413a0b8c47336'
      end

      Timecop.freeze EPOCH do
        db.mine
      end

      expect(db.hash).to eq '131f9860e82ecf8848e710a6c6ec90dd0564afbc6589cdfc5da3f7a4edd34387'
      expect(db.nonce).to eq 51067
      expect(db.time).to eq 140486400
    end
  end
end
