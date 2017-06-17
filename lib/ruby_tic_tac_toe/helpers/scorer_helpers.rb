class RubyTicTacToe
  class Scorer
    private

    def line_on_board_doesnt_contain_character?(player_character, line)
      line.each do |position|
        row, column = @config['game'].return_row_and_column_from_location(position)

        return false if @state['game-board'][row][column] == player_character
      end

      true
    end

    def line_on_board_has_two_conflicting_characters?(player_character, enemy_character, line, status = [])
      line.each do |position|
        row, column = @config['game'].return_row_and_column_from_location(position)

        status << @state['game-board'][row][column]
      end

      status.include?(player_character) && status.include?(enemy_character)
    end
  end
end
