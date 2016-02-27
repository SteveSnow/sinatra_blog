class CreateUserfollowsTable < ActiveRecord::Migration
  def change
  		create_table :userfollows do |u|
  		u.string :follows_id
  		u.string :follower_id
  		u.datetime :created_at,default: Time.now
  	end
  end
end
