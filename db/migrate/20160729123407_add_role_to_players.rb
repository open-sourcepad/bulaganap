class AddRoleToPlayers < ActiveRecord::Migration[5.0]

  def change
    add_column :players, :role, :string
  end

end
