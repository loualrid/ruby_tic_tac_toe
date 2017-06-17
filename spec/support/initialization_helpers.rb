module InitializationSpecHelpers
  def initialize_and_set_stdin_to(string_array = [], run_modes_array = [])
    allow($stdin).to receive(:gets).and_return(*string_array)

    @rttt = RubyTicTacToe.new( 'run-modes' => run_modes_array + [:quiet] )
  end
end

RSpec.configure do |config|
  config.include InitializationSpecHelpers, type: :initialization
end
