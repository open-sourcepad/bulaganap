class AddStatusToGame < ActiveRecord::Migration[5.0]

  def change
    add_column :games, :status, :string, default: "in_queue"
    add_column :games, :player_one_id, :integer
    add_column :games, :player_two_id, :integer
  end

end
