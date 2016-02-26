class User < ActiveRecord::Base
  	has_many :posts
	serialize :follows_id
end