class CreateMazes < ActiveRecord::Migration[5.0]

  def change
    create_table :mazes do |t|
      t.string :file_name
      t.timestamps
    end

    add_column :games, :maze_id, :integer
  end

end
