require 'spec_helper'

describe RubyTicTacToe::Initializer, type: :initialization do
  describe "#initialize_configuration" do
    before do
      @modes = [:skip_validation, :skip_execution]
    end

    it "should give players the choice of an x by x board" do
      initialize_and_set_stdin_to(['3'], @modes)

      expect( @rttt.dump_config['board-size'] ).to be == 3
    end

    it "should not start with a blank board of size 4x4 by default" do
      initialize_and_set_stdin_to([''], @modes)

      expect( @rttt.dump_config['board-size'] ).to_not be == 4
    end

    it "should start with a blank board of size 3x3 by default user doesn't enter anything for the board-size" do
      initialize_and_set_stdin_to([''], @modes)

      expect( @rttt.dump_config['board-size'] ).to be == 3
    end

    it "should allow the board size to be 4x4 or 5x5" do
      initialize_and_set_stdin_to(['4'], @modes)

      expect( @rttt.dump_config['board-size'] ).to be == 4

      initialize_and_set_stdin_to(['5'], @modes)

      expect( @rttt.dump_config['board-size'] ).to be == 5
    end

    it "should allow the client to set the character to be an X or O" do
      initialize_and_set_stdin_to(%w(3 X), @modes)

      expect( @rttt.dump_config['board-size'] ).to be == 3
      expect( @rttt.dump_config['player-character'] ).to be == 'X'
    end

    it "should start the player character as O if the user doesn't enter anything for the player-character" do
      initialize_and_set_stdin_to(['', ''], @modes)

      expect( @rttt.dump_config['board-size'] ).to be == 3
      expect( @rttt.dump_config['player-character'] ).to be == 'O'
    end
  end

  describe "#initialize_table", type: :execution do
    it "should be able create an 3 by 3 board stored in the state" do
      initialize_and_set_board_size(3, [:skip_execution])

      expect( @rttt.dump_state['game-board'] ).to be == ( [''] * 3 * 3 ).each_slice(3).map(&:to_a)
    end

    it "should be able create an 5 by 5 board stored in the state" do
      initialize_and_set_board_size(5, [:skip_execution])

      expect( @rttt.dump_state['game-board'] ).to be == ( [''] * 5 * 5 ).each_slice(5).map(&:to_a)
    end
  end

  describe "#initialize_winning_lines", type: :execution do
    it "should create an array of arrays stored in the state object as 'winning-lines'" do
      initialize_and_set_board_size(3, [:skip_execution])

      expect( @rttt.dump_state['winning-lines'] ).to_not be_nil
    end

    it "should create an array of winning lines for a 3x3 game" do
      initialize_and_set_board_size(3, [:skip_execution])

      winning_lines = [
        %w(A1 A2 A3),
        %w(B1 B2 B3),
        %w(C1 C2 C3),
        %w(A1 B1 C1),
        %w(A2 B2 C2),
        %w(A3 B3 C3),
        %w(A1 B2 C3),
        %w(C1 B2 A3)
      ].sort

      expect( @rttt.dump_state['winning-lines'].sort ).to be == winning_lines
    end
  end
end
