class MovesController < ApplicationController

  def create
    Move.set(move_params)
    render json: {success: true}
  end

  private

  def move_params
    params.require(:move).permit(:player_id, :direction)
  end

end
