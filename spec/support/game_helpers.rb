module GameSpecHelpers
  def initialize_and_run_game_with_inputs(string_array = [], turns_to_evaluate = 0)
    allow($stdin).to receive(:gets).and_return(*string_array)

    @rttt = RubyTicTacToe.new( 'run-modes' => [:quiet], 'turns-to-evaluate' => turns_to_evaluate )
  end
end

RSpec.configure do |config|
  config.include GameSpecHelpers, type: :game
end
