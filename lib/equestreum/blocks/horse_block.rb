module Equestreum
  class HorseBlock < Block
    def self.difficulty_attained hash, difficulty: difficulty
      hash.start_with? Equestreum.lead_string Config.instance.config['horse'],
                                              difficulty: Config.instance.config['default_difficulty']
    end
  end
end
