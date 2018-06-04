module Equestreum
  describe Chain do
    context 'initialisation' do
      it 'has the genesis block' do
        chain = test_chain
        expect(chain.first.data).to eq 'genesis block'
        expect(chain.first.hash).to eq '0009b42551ddcf2d9a87efd867f9c7c0602894868e0d24a917942870454b6dc5'
      end
    end

    context 'longer chain' do
      chain = test_chain 4
      it 'has more blocks' do
        expect(chain[1].hash).to eq '000da10f4ecb16f118f07c15e5e815ed79d781e6059f20d17241f4350d018b94'
        expect(chain[2].data).to eq 'block #2'
        expect(chain[3].nonce).to eq 5912
      end

      it 'can only grow via the `grow` method' do
        [
          :push,
          :append,
          :<<
        ].each do |method|
          expect { chain.public_send method }.to raise_exception do |ex|
            expect(ex).to be_a NoMethodError
            expect(ex.message).to match /private method/
          end
        end
      end
    end
  end
end