module Equestreum
  describe Chain do
    context 'verify itself' do

      before :each do
        @chain = test_chain 4
      end

      context 'hashes are kosher' do
        it 'verifies the hash of a block' do
          expect(@chain.hash_ok? 2).to be true
        end

        it 'verifies all of its hashes' do
          expect(@chain.hashes_ok?).to be true
        end

        it 'knows when a block has been tampered with' do
          @chain[2].data = 'Block #99'
          expect { @chain.hashes_ok? }.to raise_exception do |ex|
            expect(ex).to be_a EquestreumException
            expect(ex.text).to eq 'Block at 2 tampered with'
          end
        end
      end

      context 'proofs-of-work are kosher' do
        it 'verifies the proof-of-work of a block' do
          expect(@chain.proof_of_work_ok? 3).to be true
        end

        it 'verifies all of its proofs-of-work' do
          expect(@chain.proofs_of_work_ok?).to be true
        end

        it 'knows when a block has been tampered with' do
          @chain[3].difficulty = 10
          expect { @chain.proofs_of_work_ok? }.to raise_exception do |ex|
            expect(ex).to be_a EquestreumException
            expect(ex.text).to eq 'Inconsistent difficulty in block at 3'
          end
        end
      end

      context 'hashes are chained' do
        it 'verifies the previous hash for a block' do
          expect(@chain.previous_hash_ok? 1).to be true
        end

        it 'verifies the previous hash for the genesis block' do
          expect(@chain.previous_hash_ok? 0).to be true
        end

        it 'verifies all of its previous hashes' do
          expect(@chain.previous_hashes_ok?).to be true
        end

        it 'knows when a block has been tampered with' do
          @chain[3].prev = 'deadbeef'
          expect { @chain.previous_hashes_ok? }.to raise_exception do |ex|
            expect(ex).to be_a EquestreumException
            expect(ex.text).to eq 'Hash chain broken in block at 3'
          end
        end
      end

      context 'blocks are chronological' do
        it 'verifies that a block is newer than its predecessor' do
          expect(@chain.newer_than_last? 1).to be true
        end

        it 'verifies that time marches forward' do
          expect(@chain.blocks_get_newer?).to be true
        end

        it 'knows when a block has been tampered with' do
          Timecop.freeze '1970-01-01' do
            @chain.grow 'Block #4'
            expect { @chain.blocks_get_newer? }.to raise_exception do |ex|
              expect(ex).to be_a EquestreumException
              expect(ex.text).to eq 'Block at 4 seems older than its predecessor'
            end
          end
        end
      end

      context 'everything is verified' do
        it 'passes all verifications' do
          expect(@chain.verified?).to eq true
        end
      end
    end
  end
end
