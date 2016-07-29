class GamesController < ApplicationController

  before_action :find_game, only: [:show]

  def find_match
    Game.find_match
  end

  def show

  end

  private

  def find_game
    @game = Game.find(params[:id])
  end

end
