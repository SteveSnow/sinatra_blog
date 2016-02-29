class User < ActiveRecord::Base
  	has_many :posts
	has_many :userfollows

	def full_name
		return fname + " " + lname
	end

end