module Equestreum
  class Config
    include Singleton

    def initialize custom = "#{ENV['HOME']}/.equestreum/config.yaml"
      @config = fetch_yaml File.join(File.dirname(__FILE__), '..', '..', 'config/equestreum.yaml')
      @config.merge! fetch_yaml custom
    end

    def config
      @config
    end

    def fetch_yaml file
      YAML.load File.open file
    rescue Errno::ENOENT
      {}
    end
  end
end
