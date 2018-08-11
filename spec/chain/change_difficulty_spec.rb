module Equestreum
  describe Chain do
    context 'increase difficulty' do
      it 'still verifies when the difficulty changes' do
        chain = test_chain
        expect(chain.difficulty).to eq 3
        chain.grow 'some data'
        expect(chain.length).to eq 2
        chain.difficulty = 4
        expect(chain.verified?).to be true
        chain.grow 'more data'
        expect(chain.verified?).to be true
      end
    end
  end
end
