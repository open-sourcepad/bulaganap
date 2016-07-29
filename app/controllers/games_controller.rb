class GamesController < ApplicationController

  def find_match
    @game = Game.find_match
    render json: @game
  end

  def show
    @game = Game.find(params[:id])
    render json: @game
  end

end
