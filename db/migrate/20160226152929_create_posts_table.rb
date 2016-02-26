class CreatePostsTable < ActiveRecord::Migration
  def change
  	create_table :posts do |p|
  		p.integer :user_id
  		p.string :message
  		p.datetime :created_at,default: Time.now
  	end
  end
end
