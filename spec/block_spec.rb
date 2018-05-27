module Equestreum
  describe Block do
    context 'constructor' do
      it 'takes arguments' do
        block = Block.new do |b|
          b.data = 'equestreum'
          b.prev = '00005a04bcaba76ec015e6626b417b61874562c7b35dc4e982f413a0b8c47336'
          b.difficulty = '00'
        end

        expect(block.data).to eq 'equestreum'
      end

      it 'has default difficulty' do
        block = Block.new do |b|
          b.data = 'equestreum'
          b.prev = '00005a04bcaba76ec015e6626b417b61874562c7b35dc4e982f413a0b8c47336'
        end

        expect(block.difficulty).to eq '0000'
      end
    end
  end
end
