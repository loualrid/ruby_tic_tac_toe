class RubyTicTacToe
  class Initializer
    private

    def initialize_computer_character
      @config['computer-character'] = @config['helper'].get_other_player_character(@config['player-character'])
    end

    def initialize_configuration
      resolve_board_size

      resolve_player_character
    end

    def initialize_player_activity_hash
      @config['players'].map { |player| @state['player-activity'][player] = [] }
    end

    def initialize_table
      @config['board-size'].times do
        # X by X of ''
        @state['game-board'] << ( [''] * @config['board-size'] )
      end
    end

    def initialize_winning_lines
      headings = @config['helper'].array_of_headings

      headings.each do |column|
        # A1, A2, A3, ...
        @state['winning-lines'] << Array.new(@config['board-size']) { |i| "#{column}#{i + 1}" }
      end

      @config['board-size'].times do |i|
        # A1, B1, C1, ...
        @state['winning-lines'] << headings.map { |column| "#{column}#{i + 1}" }
      end

      # A1, B2, C3, ...
      @state['winning-lines'] << headings.map { |x| "#{x}#{headings.index(x) + 1}" }

      # A3, B2, C1, ...
      @state['winning-lines'] << headings.reverse.map { |x| "#{x}#{headings.reverse.index(x) + 1}" }
    end

    def resolve_configuration(variable, blank_default, asking_message)
      return if @config[variable] && !@config['validating']

      puts(asking_message) unless @config['run-modes'].include?(:quiet)

      @config[variable] = $stdin.gets.chomp

      @config[variable] = blank_default if @config[variable].blank?
    end
  end
end
