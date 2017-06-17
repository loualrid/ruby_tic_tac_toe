class RubyTicTacToe
  class Validator
    private

    def board_size_error(specific_error)
      puts(
        "You attempted to force board-size to be #{specific_error}, " \
        "we'll ask for a number again and please use a number higher than 2 " \
        "and less than 27"
      ) unless @config['run-modes'].include?(:quiet)

      @config['board-size'] = nil

      @config['initializer'].resolve_board_size

      @config['initializer'].normalize_board_size

      validate_board_size
    end

    def move_input_contains_too_many_characters(input)
      return true if input.length > 4
      return true if input.scan(/\D+/).length > 2
      return true if input.scan(/\d+/).length > 2

      false
    end
  end
end
