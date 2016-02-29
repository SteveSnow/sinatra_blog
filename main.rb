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


get'/profile/:id' do
	@user = User.find(params[:id])
	@posts = @user.posts
	if session[:user_id]
		@me = current_user
		erb :profile 
	else
		erb :profile
	end
end

get '/settings/:id' do
	@user = User.find(params[:id])
	erb :settings
end

post '/settings' do
		puts "*********************************************************************************"
	@user = User.find(session[:user_id])
	@user.fname = params[:fname]
	@user.lname = params[:lname]
	@user.email = params[:email]
	@user.password = params[:password]
	@user.save
	redirect '/'
end

post '/delete-profile' do

	@user = current_user

	if params[:password].empty?
		flash[:alert] = "Password cannot be empty!"
		redirect back
	elsif @user.password == params[:password]
		User.destroy(@user)
		session.clear
		flash[:notice] = "Your Twizzle account been deleted!"
		redirect '/'
	else
		flash[:alert] = "Password was incorrect!"
		redirect back
	end

end