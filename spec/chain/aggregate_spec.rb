module Equestreum
  describe Chain do
    context 'aggregation' do
      it 'aggregates data' do
        c = Chain.new
        8.times do |i|
          c.grow :horses
        end
        4.times do |i|
          c.grow :duck
        end
        c.save

        expect(Chain.aggregate).to eq (
          {
            duck: 4,
            horses: 8
          }
        )
      end
    end
  end
end
