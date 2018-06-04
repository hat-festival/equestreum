module Equestreum
  describe Hasher do
    context 'verify proof-of-work' do
      context 'search at start-of-hash' do
          context 'single character' do
          it 'verifies when the search string is present' do
            hash = '0fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'
            expect(described_class.proven hash, search_string: '0').to be true
          end

          it 'does not verify when the search string is not present' do
            hash = 'ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'
            expect(described_class.proven hash, search_string: '0').to be false
          end
        end

        context 'two characters' do
          it 'verifies when the search string is present' do
            hash = '01ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'
            expect(described_class.proven hash, search_string: '01').to be true
          end

          it 'does not verify when the search string is not present' do
            hash = '0fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'
            expect(described_class.proven hash, search_string: '00').to be false
          end
        end

        context 'eight characters' do
          it 'verifies when the search string is present' do
            hash = '01234567ffffffffffffffffffffffffffffffffffffffffffffffffffffffff'
            expect(described_class.proven hash, search_string: '01234567').to be true
          end

          it 'does not verify when the search string is not present' do
            hash = '0123ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'
            expect(described_class.proven hash, search_string: '01234567').to be false
          end
        end

        context 'widen the search search_width' do
          context 'find a two-character string inside the first four characters' do
            specify 'hash contains the search string in a valid position' do
              hash = 'ff01ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'
              expect(described_class.proven hash, search_string: '01', search_width: 4).to be true
            end

            specify 'hash contains the search string in a invalid position ' do
              hash = 'fff01fffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'
              expect(described_class.proven hash, search_string: '01', search_width: 4).to be false
            end

            specify 'hash does not contain the search string' do
              hash = '123fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'
              expect(described_class.proven hash, search_string: '012', search_width: 4).to be false
            end
          end

          context 'find a four-character string inside the first 16 characters' do
            specify 'hash contains the search string in a valid position' do
              hash = 'fffffffffff0123fffffffffffffffffffffffffffffffffffffffffffffffff'
              expect(described_class.proven hash, search_string: '0123', search_width: 16).to be true
            end

            specify 'hash contains the search string in a invalid position ' do
              hash = 'fffffffffffffff0123fffffffffffffffffffffffffffffffffffffffffffff'
              expect(described_class.proven hash, search_string: '0123', search_width: 16).to be false
            end

            specify 'hash does not contain the search string' do
              hash = 'fffffffffffffff1234fffffffffffffffffffffffffffffffffffffffffffff'
              expect(described_class.proven hash, search_string: '0123', search_width: 16).to be false
            end
          end

          context 'find an eight-character string anywhere' do
            specify 'hash contains the search string in a valid position' do
              hash = 'ffffffffffffffffffffffffff01234567ffffffffffffffffffffffffffffff'
              expect(described_class.proven hash, search_string: '01234567', search_width: 64).to be true
            end

            specify 'hash contains the search string right at the end' do
              hash = 'ffffffffffffffffffffffffffffffffffffffffffffffffffffffff01234567'
              expect(described_class.proven hash, search_string: '01234567', search_width: 64).to be true
            end

            specify 'hash does not contain the search string' do
              hash = 'ffffffffffffffffffffffffff12345678ffffffffffffffffffffffffffffff'
              expect(described_class.proven hash, search_string: '01234567', search_width: 16).to be false
            end
          end
        end
      end
    end

    context 'generate hashes' do
      it 'generates a hash' do
        Timecop.freeze EPOCH do
          nonce = 0
          search_string = '01234567'
          previous_hash = 'ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'
          data = 'equestreum'

          expect(described_class.hash nonce, search_string, previous_hash, data).to eq (
            '4ea47bd629d19d16fc31fa3ba6db4d5a2a4b179a3e29518957f4437ca085b4a4'
          )
        end
      end
    end
  end
end
