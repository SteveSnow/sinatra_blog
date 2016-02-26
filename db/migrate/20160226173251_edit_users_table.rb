class EditUsersTable < ActiveRecord::Migration
  def change
  	remove_column :Users, :follows_id
  end
end
