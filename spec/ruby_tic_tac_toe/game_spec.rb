require 'spec_helper'

describe RubyTicTacToe::Game, type: [:game, :execution] do
  describe "#render_table" do
    it "should be able to render the table" do
      initialize_and_set_board_size(5, [:skip_execution])

      expect( @rttt.render_table ).to_not be_nil
    end

    it "should return a 'table' object" do
      initialize_and_set_board_size(3, [:skip_execution])

      expect( @rttt.render_table.class.to_s ).to be == 'Terminal::Table'
    end

    it "should contain headers and 'siders'" do
      initialize_and_set_board_size(3, [:skip_execution])

      expect( @rttt.render_table.to_s ).to include('A', 'B', 'C', '1', '2', '3')
    end
  end

  describe "first round tests for the cpu on a 3x3 board" do
    before do
      initialize_and_set_board_size(3, [], 1)
    end

    it "should have the CPU decide an optimal first move for a 3x3 board" do
      expect( @rttt.character_at_location('B2') ).to be == 'X'
    end

    it "should keep track that the cpu played at B2 in the turns-played state" do
      expect( @rttt.dump_state['player-activity']['X'] ).to be == ['B2']
    end

    it "should be able to check that a position is no longer available" do
      expect( @rttt.empty_locations ).to_not be_empty
      expect( @rttt.empty_locations ).to_not include('B2')
    end
  end

  describe "first round tests for the cpu on a X by X board" do
    it "should be able to take a position" do
      initialize_and_set_board_size(4, [], 1)

      expect( @rttt.empty_locations ).to_not be_empty
    end
  end

  describe "first round tests for the client", type: :game do
    it "should let the client choose any position on a X by X board if they pick X" do
      initialize_and_run_game_with_inputs(%w(3 X B2), 1)

      expect( @rttt.dump_state['player-activity']['X'] ).to be == ['B2']

      initialize_and_run_game_with_inputs(%w(5 X E1), 1)

      expect( @rttt.dump_state['player-activity']['X'] ).to be == ['E1']
    end
  end

  describe "three rounds of the game", type: :game do
    it "should be able to execute with the cpu going first" do
      initialize_and_run_game_with_inputs(%w(3 O), 1)

      expect( @rttt.empty_locations.length ).to be == 8

      allow($stdin).to receive(:gets).and_return(@rttt.empty_locations.first)

      @rttt.force_turn

      expect( @rttt.empty_locations.length ).to be == 7

      @rttt.force_turn

      expect( @rttt.empty_locations.length ).to be == 6
    end

    it "should be able to execute with the client going first" do
      initialize_and_run_game_with_inputs(%w(3 X B2), 1)

      expect( @rttt.empty_locations.length ).to be == 8

      @rttt.force_turn

      expect( @rttt.empty_locations.length ).to be == 7

      allow($stdin).to receive(:gets).and_return(@rttt.empty_locations.first)

      @rttt.force_turn

      expect( @rttt.empty_locations.length ).to be == 6
    end
  end
end
