class GamesController < ApplicationController

  def find_match
    @game = Game.find_match
    render json: @game
  end
  
end
