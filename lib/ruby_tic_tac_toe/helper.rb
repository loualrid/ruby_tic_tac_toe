class RubyTicTacToe
  class Helper
    def initialize(config, state)
      @config = config
      @state  = state
    end

    def array_of_headings
      ('A'..'Z').take(@config['board-size'])
    end

    def array_of_siders
      ('1'..'27').take(@config['board-size'])
    end

    def dump_config
      @config
    end

    def dump_state
      @state
    end

    def get_other_player_character(player_character)
      @config['players'].select { |character| character != player_character }.first
    end
  end
end
