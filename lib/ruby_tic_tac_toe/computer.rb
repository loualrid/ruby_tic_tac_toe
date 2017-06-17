class RubyTicTacToe
  class Computer
    def initialize(config, state)
      @config = config
      @state  = state
    end

    def find_move(return_position = '')
      return_position = find_starting_position if @state['turns-played'].zero?

      (0..@config['board-size']).to_a.reverse.each do |move_score|
        return_position = find_move_with_resulting_score_of(move_score) if return_position.blank?
      end

      return_position = @config['game'].empty_locations.first if return_position.blank?

      return_position
    end
  end
end
