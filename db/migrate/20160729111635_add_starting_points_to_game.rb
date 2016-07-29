class AddStartingPointsToGame < ActiveRecord::Migration[5.0]

  def change
    add_column :games, :starting_point_player1, :integer, array: true
    add_column :games, :starting_point_player2, :integer, array: true
  end
end
