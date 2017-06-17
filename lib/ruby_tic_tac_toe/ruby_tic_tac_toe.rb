require 'terminal-table'
require 'terminal-table/import'
require 'active_support'
require 'active_support/core_ext'

Dir["#{File.dirname(__FILE__)}/../**/*.rb"].each { |f| require f }

class RubyTicTacToe
  def initialize(config = {}, state = {})
    @config = config
    @state  = state

    @config['start-time']          = Time.now
    @config['run-modes']         ||= []
    @config['turns-to-evaluate'] ||= 0
    @config['players']           ||= %w(X O)
    @config['helper']              = Helper.new(@config, @state)
    @config['validator']           = Validator.new(@config, @state)
    @config['scorer']              = Scorer.new(@config, @state)
    @config['game']                = Game.new(@config, @state)
    @config['computer']            = Computer.new(@config, @state)

    @state['current-turn']    = 'X'
    @state['game-board']      = []
    @state['winning-lines']   = []
    @state['turns-played']    = 0
    @state['player-activity'] = {}

    @config['initializer'] = Initializer.new(@config, @state)

    @config['validator'].validate_configuration

    @config['game'].run
  end

  def character_at_location(location)
    @config['game'].character_at_location(location)
  end

  def dump_config
    @config['helper'].dump_config
  end

  def dump_state
    @config['helper'].dump_state
  end

  def empty_locations
    @config['game'].empty_locations
  end

  def force_turn
    @config['game'].force_turn
  end

  def insert_move_into_board(location, character)
    @config['game'].insert_move_into_board(location, character)
  end

  def render_table
    @config['game'].render_table
  end

  def score_of_player(player_character)
    @config['scorer'].score_of_player(player_character)
  end
end
