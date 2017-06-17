class RubyTicTacToe
  class Computer
    private

    def find_empty_position_on_line(line, empty_positions = [])
      return '' unless line.is_a? Array

      line.each do |position|
        row, column = @config['game'].return_row_and_column_from_location(position)

        empty_positions << position if @state['game-board'][row][column] == ''
      end

      # Ensuring "poor" moves are random picks
      empty_positions[rand(empty_positions.length)]
    end

    def find_starting_position
      return '' if @config['board-size'].even?

      headings = @config['helper'].array_of_headings
      siders   = @config['helper'].array_of_siders

      column = headings[(headings.length / 2)]
      row    = siders[(siders.length / 2)]

      "#{column}#{row}"
    end

    def find_move_with_resulting_score_of(move_score, lines = [])
      @state['winning-lines'].each do |line|
        lines << line if @config['scorer'].score_of_current_line(line, @config['computer-character']) == ( move_score - 1 )

        # Defensive play
        lines << line if @config['scorer'].score_of_current_line(line, @config['player-character']) == ( move_score - 1 )
      end

      # Using rand here ensures that moves with a resulting score of 0 and 1 are "random" picks
      find_empty_position_on_line(lines[rand(lines.length)])
    end
  end
end
