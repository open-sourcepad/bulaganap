class Game < ApplicationRecord

  has_many :players
  belongs_to :maze, optional: true

  def self.find_match
    new_player = Player.create #still no game_id
    game = Game.where(status: "in_queue").order("created_at DESC").first
    if game.nil?
      game = Game.create(player_one_id: new_player.id, maze_id: Maze.random.id)
      new_player.update_attributes(game_id: game.id, role: "player1")
      # subscribe to channel1, wait for player 2
    else
      game.update_attributes(player_two_id: new_player.id, status: "started")
      new_player.update_attributes(game_id: game.id, role: "player2")
      game.start
    end
    {game_id: game.id, player_id: new_player.id, player_role: new_player.role}
  end

  # subscribe to channel2, game start, countdown begins
  def start
    # always load so no restarting of server is needed'
    maze_config = YAML.load_file(maze.file_name)
    # set starting points
    update_attributes(starting_point_player1: maze_config["starting_points_for_player1"].values.sample, starting_point_player2: maze_config["starting_points_for_player2"].values.sample)
    # set countdown via pusher
  end

end
