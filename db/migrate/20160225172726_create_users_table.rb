class CreateUsersTable < ActiveRecord::Migration
  def change
  		create_table :users do |u|
  		u.string :fname
  		u.string :lname
  		u.string :email
  		u.string :password
  		u.string :follows_id
  		u.datetime :created_at,default: Time.now
  	end
  end
end
