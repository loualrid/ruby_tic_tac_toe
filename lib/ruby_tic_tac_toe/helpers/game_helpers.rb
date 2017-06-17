class RubyTicTacToe
  class Game
    private

    def game_is_complete?
      return true if @config['turns-to-evaluate'] == @state['turns-played'] && @config['turns-to-evaluate'].positive?

      return winner('X') if @config['scorer'].score_of_player('X') == @config['board-size']

      return winner('O') if @config['scorer'].score_of_player('O') == @config['board-size']

      return game_draw if empty_locations.length.zero?

      @state['turns-played'] >= ( @config['board-size'] * @config['board-size'] )
    end

    def execute_turn
      send("execute_#{@state['current-turn'].downcase}_turn")

      @state['turns-played'] += 1
    end

    def execute_x_turn
      execute_player_turn   if @config['player-character'] == 'X'

      execute_computer_turn if @config['computer-character'] == 'X'

      @state['current-turn'] = 'O'
    end

    def execute_o_turn
      execute_player_turn if @config['player-character'] == 'O'

      execute_computer_turn if @config['computer-character'] == 'O'

      @state['current-turn'] = 'X'
    end

    def execute_computer_turn
      move_location = @config['computer'].find_move

      insert_move_into_board(move_location, @state['current-turn'])

      @state['player-activity'][@config['computer-character']] << move_location
    end

    def game_draw
      puts("\nThe game is over! It was a tie...") unless @config['run-modes'].include?(:quiet)

      render_table

      true
    end

    def winner(character)
      puts("\nThe game is over! #{character} wins!") unless @config['run-modes'].include?(:quiet)

      render_table

      true
    end
  end
end
