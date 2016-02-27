class User < ActiveRecord::Base
  	has_many :posts
	serialize :follows_id

	def full_name
		return fname + " " + lname
	end

end