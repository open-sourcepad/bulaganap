class Maze < ApplicationRecord

  def self.random
    offset = rand(Maze.count)
    Maze.offset(offset).first
  end

end
