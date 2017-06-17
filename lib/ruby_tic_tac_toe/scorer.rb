class RubyTicTacToe
  class Scorer
    def initialize(config, state)
      @config = config
      @state  = state
    end

    def score_of_current_line(line, player_character, current_line_score = 0)
      enemy_character = @config['helper'].get_other_player_character(player_character)

      line.each do |position|
        # we don't care about the score of lines where the player hasn't played in
        next if line_on_board_doesnt_contain_character?(player_character, line)

        # we don't care about the score of lines where the player and opponent are opposing
        next if line_on_board_has_two_conflicting_characters?(player_character, enemy_character, line)

        row, column = @config['game'].return_row_and_column_from_location(position)

        current_line_score += 1 if @state['game-board'][row][column] == player_character
      end

      current_line_score
    end

    def score_of_player(player_character, score_of_lines = [0])
      @state['winning-lines'].each do |line|
        score_of_lines << score_of_current_line(line, player_character)
      end

      # fetch the highest score of the winning lines
      score_of_lines.sort.reverse.first
    end
  end
end
