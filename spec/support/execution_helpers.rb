module ExecutionSpecHelpers
  def initialize_and_set_board_size(size, extra_modes = [], turns_to_evaluate = 0)
    modes = [:skip_validation, :skip_configuration, :quiet] + extra_modes

    @rttt = RubyTicTacToe.new(
      'run-modes' => modes,
      'player-character' => 'O',
      'board-size' => size.to_s,
      'turns-to-evaluate' => turns_to_evaluate
    )
  end
end

RSpec.configure do |config|
  config.include ExecutionSpecHelpers, type: :execution
end
