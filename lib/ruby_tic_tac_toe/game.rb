class RubyTicTacToe
  class Game
    def initialize(config, state)
      @config = config
      @state  = state
    end

    def run
      return if @config['run-modes'].include?(:skip_execution)

      execute_turn while !game_is_complete?
    end

    def character_at_location(location)
      row, column = return_row_and_column_from_location(location)

      @state['game-board'][row][column]
    end

    def empty_locations(locations_to_return = [], locations = [])
      @config['helper'].array_of_headings.each do |heading|
        locations << @config['helper'].array_of_siders.map { |sider| "#{heading}#{sider}" }
      end

      locations = locations.flatten

      locations.each do |location|
        row, column = @config['game'].return_row_and_column_from_location(location)

        locations_to_return << location if @state['game-board'][row][column] == ''
      end

      locations_to_return
    end

    def execute_player_turn
      render_table unless @config['run-modes'].include?(:quiet)

      puts('Where do you want to move?') unless @config['run-modes'].include?(:quiet)

      move_location = @config['validator'].validate_move($stdin.gets.chomp)

      insert_move_into_board(move_location, @state['current-turn'])

      @state['player-activity'][@config['player-character']] << move_location
    end

    def force_turn
      execute_turn
    end

    def insert_move_into_board(location, character)
      row, column = return_row_and_column_from_location(location)

      @state['game-board'][row][column] = character
    end

    def return_row_and_column_from_location(location)
      column = @config['helper'].array_of_headings.index(location.scan(/\D+/).first)
      row    = location.scan(/\d+/).first.to_i - 1

      [row, column]
    end

    def render_table(current_row = 1, state_with_siders = [])
      @state['game-board'].each do |row|
        state_with_siders << [current_row] + row

        current_row += 1
      end

      board = Terminal::Table.new do |table|
        table.headings = @config['helper'].array_of_headings.unshift('')
        state_with_siders.each do |row|
          table.add_row row
          table.add_row :separator unless state_with_siders.index(row) == ( @config['board-size'] - 1 )
        end
      end

      puts("#{board}\n\n") unless @config['run-modes'].include?(:quiet)

      board
    end
  end
end
