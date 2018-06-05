
start = Digest::SHA256.hexdigest Random.rand(2**4096).to_s
search_string = '000'
search_width = 64
solved = false
nonce = 0

until solved do
  hash = Equestreum::Hasher.hash nonce, search_string, start, 'equestreum'
  puts hash
end
