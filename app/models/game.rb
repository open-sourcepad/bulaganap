class Game < ApplicationRecord

  def self.find_match
    new_player = Player.create #still no game_id
    game = Game.where(status: "in_queue").order("created_at DESC").first
    if game.nil?
      new_game = Game.create(player_one_id: new_player.id)
      new_player.update_attributes(game_id: new_game.id)
      # subscribe to channel1, wait for player 2
    else
      game.update_attributes(player_two_id: new_player.id, status: "started")
      # subscribe to channel2, game start, countdown begins
    end
  end

end
