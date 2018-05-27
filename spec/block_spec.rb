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

        Timecop.freeze '1974-06-15' do
          block.mine
        end

        expect(block.hash).to eq '03b3e7d06e697ce00a58664e5f56f527a89bbd3f877e1ebd90deb278cb7cc9d2'
        expect(block.nonce).to eq 9
        expect(block.data).to eq 'equestreum'
        expect(block.time).to eq 140482800
      end
    end
  end
end
