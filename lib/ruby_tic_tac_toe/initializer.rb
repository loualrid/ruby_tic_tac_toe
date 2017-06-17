class RubyTicTacToe
  class Initializer
    def initialize(config, state)
      @config = config
      @state  = state

      initialize_configuration unless @config['run-modes'].include?(:skip_configuration)

      initialize_computer_character

      normalize_board_size

      initialize_table

      initialize_winning_lines

      initialize_player_activity_hash
    end

    def normalize_board_size
      @config['board-size'] = @config['board-size'].to_i
    end

    def resolve_board_size
      resolve_configuration(
        'board-size',
        '3',
        'How large do you want the board to be? ' \
        'Enter blank to get a 3x3 board or just input one number to make an x by x board.'
      )
    end

    def resolve_player_character
      resolve_configuration(
        'player-character',
        'O',
        'What character would you like to start as? Entering blank will start you as O.'
      )
    end
  end
end
