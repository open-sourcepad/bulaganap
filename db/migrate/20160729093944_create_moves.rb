class CreateMoves < ActiveRecord::Migration[5.0]

  def change
    create_table :moves do |t|
      t.integer :game_id
      t.integer :player_id
      t.integer :from_point, array: true, default: '{}'
      t.integer :to_point, array: true, default: '{}'
      t.timestamps
    end
  end

end
