class RubyTicTacToe
  class Validator
    def initialize(config, state)
      @config = config
      @state  = state
    end

    def move_error(specific_error)
      puts(
        "What you entered contains #{specific_error}, we'll ask for a valid " \
        "move spot again and this time please use a value within the bounds of " \
        "the board."
      ) unless @config['run-modes'].include?(:quiet)

      validate_move($stdin.gets.chomp)
    end

    def validate_board_size
      case @config['board-size'].to_i
      when 0..2
        board_size_error('less than 3')
      when 3..27
      else
        board_size_error('something unexpected')
      end
    end

    def validate_configuration
      return if @config['run-modes'].include?(:skip_validation)

      validate_board_size

      validate_player
    end

    def validate_move(input)
      input = move_error('nothing')               if input.blank?
      input = move_error('no valid headers')      if !@config['helper'].array_of_headings.include?(input.scan(/\D+/).first)
      input = move_error('no valid siders')       if !@config['helper'].array_of_siders.include?(input.scan(/\d+/).first)
      input = move_error('too many characters')   if move_input_contains_too_many_characters(input)
      input = move_error('an already taken spot') if !@config['game'].empty_locations.include?(input)

      input
    end

    def validate_player
      case @config['player-character']
      when 'X'
      when 'x' || 'o'
        @config['player-character'] = @config['player-character'].upcase
      when 'O'
      else
        puts(
          "You attempted to force the player to be something " \
          "that is neither an X or an O. We'll ask for a character " \
          "again and please use either X or O"
        ) unless @config['run-modes'].include?(:quiet)

        @config['player-character'] = nil

        @config['initializer'].resolve_player_character

        validate_player
      end
    end
  end
end
