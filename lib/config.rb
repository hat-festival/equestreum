module Equestreum
  class Config
    include Singleton

    def initialize
      @config = fetch_yaml File.join(File.dirname(__FILE__), '..', '..', 'config/equestreum.yaml')
      @config.merge! fetch_yaml "#{ENV['HOME']}/.equestreum/config.yaml"
    end

    def config
      @config
    end

    def fetch_yaml file
      YAML.load_file file
    rescue Errno::ENOENT
      {}
    end
  end
end
