require 'spec_helper'

describe RubyTicTacToe::Validator, type: :initialization do
  describe "#validate_configuration" do
    before do
      @modes = [:skip_execution]
    end

    it "should not allow board-size to be a 'string' that is not an integer" do
      initialize_and_set_stdin_to(%w(test X 3), @modes)

      expect(@rttt.dump_config['board-size']).to_not be == 'test'
      expect(@rttt.dump_config['player-character']).to be == 'X'
    end

    it "should not allow player-character to be a Y" do
      initialize_and_set_stdin_to(%w(3 Y X), @modes)

      expect(@rttt.dump_config['board-size']).to be == 3
      expect(@rttt.dump_config['player-character']).to_not be == 'Y'
    end

    it "should not allow player-character to be a Z and board-size to be 'test'" do
      initialize_and_set_stdin_to(%w(test Z 3 O), @modes)

      expect(@rttt.dump_config['board-size']).to_not be == 'test'
      expect(@rttt.dump_config['player-character']).to_not be == 'Z'
    end

    it "should allow the board-size and player-character to be 5 and O respectively" do
      initialize_and_set_stdin_to(%w(5 O), @modes)

      expect(@rttt.dump_config['board-size']).to be == 5
      expect(@rttt.dump_config['player-character']).to be == 'O'
    end

    it "should not crash if the user passes in several bad inputs" do
      initialize_and_set_stdin_to(%w(X Y a b c 3 X), @modes)

      expect(@rttt.dump_config['board-size']).to be == 3
      expect(@rttt.dump_config['player-character']).to be == 'X'
    end
  end

  describe "invalid moves for the client", type: :game do
    it "should not let the client input gibberish for a move" do
      initialize_and_run_game_with_inputs(%w(3 X CXYZ321 B2), 1)

      expect( @rttt.dump_state['player-activity']['X'] ).to be == ['B2']
    end

    it "should not let the client input a position that is invalid for the game" do
      initialize_and_run_game_with_inputs(%w(3 X C4 C1), 1)

      expect( @rttt.dump_state['player-activity']['X'] ).to be == ['C1']
    end

    it "should not let the client input a position that is already taken" do
      initialize_and_run_game_with_inputs(%w(3 O B2 C1), 2)

      expect( @rttt.dump_state['player-activity']['X'] ).to be == ['B2']
      expect( @rttt.dump_state['player-activity']['O'] ).to be == ['C1']
    end
  end
end
