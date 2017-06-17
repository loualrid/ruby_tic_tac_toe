require 'spec_helper'

describe RubyTicTacToe::Scorer, type: [:game, :execution] do
  describe "#score_of_player" do
    it "should be able to determine the point value of a character in a game that is in progress" do
      initialize_and_set_board_size(3, [:skip_execution])

      #   A B C
      # 1 O   X
      # 2   X
      # 3 O

      @rttt.insert_move_into_board('B2', 'X')
      @rttt.insert_move_into_board('A1', 'O')
      @rttt.insert_move_into_board('C1', 'X')
      @rttt.insert_move_into_board('A3', 'O')

      expect( @rttt.score_of_player('O')).to be == 2
      expect( @rttt.score_of_player('X')).to be == 1
    end

    it "should be able to determine the point value of a tie game" do
      initialize_and_set_board_size(3, [:skip_execution])

      #   A B C
      # 1 O O X
      # 2 X X O
      # 3 O X X

      @rttt.insert_move_into_board('B2', 'X')
      @rttt.insert_move_into_board('A1', 'O')
      @rttt.insert_move_into_board('C1', 'X')

      @rttt.insert_move_into_board('A3', 'O')
      @rttt.insert_move_into_board('A2', 'X')
      @rttt.insert_move_into_board('C2', 'O')

      @rttt.insert_move_into_board('B3', 'X')
      @rttt.insert_move_into_board('B1', 'O')
      @rttt.insert_move_into_board('C3', 'X')

      expect( @rttt.score_of_player('O')).to be == 0
      expect( @rttt.score_of_player('X')).to be == 0
    end

    it "should be able to determine the point value of a 4x4 game that is in progress" do
      initialize_and_set_board_size(4, [:skip_execution])

      #   A B C D
      # 1
      # 2   X O
      # 3 X O O
      # 4   X X O

      @rttt.insert_move_into_board('B2', 'X')
      @rttt.insert_move_into_board('C3', 'O')
      @rttt.insert_move_into_board('B4', 'X')

      @rttt.insert_move_into_board('B3', 'O')
      @rttt.insert_move_into_board('C4', 'X')
      @rttt.insert_move_into_board('D4', 'O')

      @rttt.insert_move_into_board('A3', 'X')
      @rttt.insert_move_into_board('C2', 'O')

      expect( @rttt.score_of_player('O')).to be == 2
      expect( @rttt.score_of_player('X')).to be == 1
    end
  end
end
