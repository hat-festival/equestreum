require 'bundler/setup'
require 'timecop'
require 'coveralls'
Coveralls.wear!

require 'equestreum'

EPOCH = Time.parse('1974-06-15T00:00:00Z')

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before :all do
    FileUtils.rm_rf 'tmp/'
    FileUtils.mkdir_p 'tmp/'
  end

  config.before :each do
    fixture_yaml = YAML.load_file 'spec/fixtures/config.yaml'
    allow(YAML).to receive(:load_file).and_call_original
    allow(YAML).to receive(:load_file).
      with("config/equestreum.yaml").and_return(fixture_yaml)
  end
end

def test_chain length = 1
  start_date = EPOCH
  chain = nil

  Timecop.freeze start_date do
    chain = Equestreum::Chain.new
  end

  (length - 1).times do |i|
    Timecop.freeze start_date + (86400 * (i + 1)) do
      chain.grow "block ##{i + 1}"
    end
  end

  chain
end
