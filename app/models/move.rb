class Move < ApplicationRecord

  belongs_to :game, optional: true
  belongs_to :player, optional: true

  def self.set move_params
    player = Player.find(move_params[:player_id])
    maze_config = YAML.load_file(player.game.maze.file_name)
    from_point = self.set_from_point(move_params, player, maze_config)
    points = self.get_points(move_params[:direction], from_point)
    Move.create(game_id: player.game.id, player_id: player.id, from_point: points[:fp], to_point: points[:tp])
    # check whether invalid, then push event to pusher
  end

  def self.set_from_point move_params, player, maze_config
    move_count = Move.where(game_id: player.game_id).count
    if move_count == 0
      # player is moving from starting point
      player.game.send("starting_point_#{player.role}")
    else
      # get last point from latest move
      last_move = Move.where(game_id: player.game_id).last
      fp = last_move.to_point
      # check if it is a wall or exceed bounding box
      if maze_config["walls"].values.include?(fp) || maze_config["min_x"] > fp.first || maze_config["min_y"] > fp.last || maze_config["max_x"] < fp.first || maze_config["max_y"] < fp.last
        last_move.from_point
      else
        fp
      end
    end
  end

  def self.get_points direction, from_point
    case direction
    when "right"
      {fp: from_point, tp: [from_point.first + 1, from_point.last]}
    when "left"
      {fp: from_point, tp: [from_point.first - 1, from_point.last]}
    when "up"
      {fp: from_point, tp: [from_point.first, from_point.last - 1]}
    when "down"
      {fp: from_point, tp: [from_point.first, from_point.last + 1]}
    end
  end

end
