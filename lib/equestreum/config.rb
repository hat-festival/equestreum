module Equestreum
  class Config
    include Singleton

    def initialize
      @config = fetch_yaml File.join(File.dirname(__FILE__), '..', '..', 'config/equestreum.yml')
      @config.merge! fetch_yaml 'config/equestreum.yml' if File.exists? 'config/equestreum.yml'
    end

    def config
      @config
    end

    def fetch_yaml file
      YAML.load_file file
    end
  end
end
