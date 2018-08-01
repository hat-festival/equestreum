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

      it 'presents as a hash' do
        Timecop.freeze EPOCH do
          @block = Block.new do |b|
            b.data = 'equestreum'
            b.prev = '00005a04bcaba76ec015e6626b417b61874562c7b35dc4e982f413a0b8c47336'
            b.difficulty = 2
          end
          @block.mine
        end

        expect(@block.to_h).to eq (
          {
            data: 'equestreum',
            time: 140486400,
            hash: '00a0874a902c2a2a0ef8ed96e4aacb6431df38a3f999b664809980e76b788021',
            prev: '00005a04bcaba76ec015e6626b417b61874562c7b35dc4e982f413a0b8c47336',
            nonce: 43,
            difficulty: 2
          }
        )
      end
    end
  end
end
