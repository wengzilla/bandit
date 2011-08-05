require "bandit/version"
require "bandit/exceptions"
require "bandit/experiments"
require "bandit/metric"
require "bandit/pit_boss"
require "bandit/players/base"
require "bandit/players/round_robin"
require "bandit/storage/base"
require "bandit/storage/memory"
require "bandit/config"

module Bandit
  def self.config
    @config ||= Config.new
  end

  def self.setup(&block)
    yield config
    config.check!
  end  

  def self.storage
    @storage ||= BaseStorage.get_storage(Bandit.config.storage, Bandit.config.storage_config)
  end

  def self.player
    @player ||= BasePlayer.get_player(Bandit.config.player, Bandit.config.player_config)
  end
end
