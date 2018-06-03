module Equestreum
  class DuckBlock < Block
    def self.difficulty_attained hash, difficulty: difficulty
      hash.start_with? Equestreum.lead_string Config.instance.config['duck'],
                                              difficulty: Config.instance.config['default_difficulty']
    end
  end
end
