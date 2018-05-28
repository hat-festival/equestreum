module Equestreum
  describe Chain do
    genesis = Block.new do |b|
      b.data = 'genesis block'
      b.prev = '0000000000000000000000000000000000000000000000000000000000000000'
      b.difficulty = 3
    end

    Timecop.freeze '1974-06-15' do
      genesis.mine
    end

    chain = Chain.new genesis

    Timecop.freeze '1974-06-17' do
      chain.grow 'horses'
    end

    Timecop.freeze '1974-06-18' do
      chain.grow 'duck'
    end

    Timecop.freeze '1974-06-19' do
      chain.grow 'duck'
    end

    context 'read data' do
      it 'yields its data' do
        expect(chain.data).to eq (
          [
            {
              datetime: '1974-06-17T00:00:00+01:00',
              data: 'horses'
            },
            {
              datetime: '1974-06-18T00:00:00+01:00',
              data: 'duck'
            },
            {
              datetime: '1974-06-19T00:00:00+01:00',
              data: 'duck'
            }
          ]
        )
      end

      it 'yields its data including the genesis block' do
        expect(chain.data with_genesis: true).to eq (
          [
            {
              datetime: '1974-06-15T00:00:00+01:00',
              data: 'genesis block'
            },
            {
              datetime: '1974-06-17T00:00:00+01:00',
              data: 'horses'
            },
            {
              datetime: '1974-06-18T00:00:00+01:00',
              data: 'duck'
            },
            {
              datetime: '1974-06-19T00:00:00+01:00',
              data: 'duck'
            }
          ]
        )
      end
    end
  end
end
