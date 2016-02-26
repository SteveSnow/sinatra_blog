require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup'
configure(:development){set :database, "sqlite3:blog.sqlite3"}
require './models/Users'
require './models/Posts'

set :database, "sqlite3:blog.sqlite3"

get "/" do
	@user=User.find(1)
	erb:home
end