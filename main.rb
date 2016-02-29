require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup'
require 'rack-flash'
enable :sessions
use Rack::Flash, :sweep => true
configure(:development){set :database, "sqlite3:blog.sqlite3"}
require './models/Users'
require './models/Posts'
require './models/Userfollows'

set :database, "sqlite3:blog.sqlite3"
set :sessions, true

def current_user
	if session[:user_id]
		@current_user = User.find(session[:user_id])
	end
end

get '/' do
	@users=User.all
	if session[:user_id]
		@user = current_user
		@fids=Userfollow.where(follower_id: @user.id)
		 # @posts = Post.where(user_id: @fids.follows_id)
# @posts=@user.posts
@posts=Post.all
		erb :home
	else
		redirect '/signin'
	end	
end



get '/signin' do
	erb :signin
end

post '/signin' do
	puts "***************************************"
	@user = User.where(email: params[:email]).first
	if @user && @user.password == params[:password]
		session[:user_id] = @user.id
		redirect '/'
	else
		flash[:alert] = "Login failed."
		redirect '/users/new'
	end
end

get '/logout' do
	if session[:user_id] 
		session.clear
		flash[:notice] = "You have been logged out!"
		redirect '/'
	else
		redirect '/'
	end
end

get'/profile/:id' do
	puts "****************************"
	@user = User.find(params[:id])
	@posts = @user.posts
	if session[:user_id]
		@me = current_user
		erb :profile 
	else
		erb :profile
	end
end

post '/delete-post' do
	@post = params[:post_id]
	Post.destroy(@post)
	flash[:notice] = "Your Post has been deleted!"
	redirect '/'
end

post '/newpost' do
	if session[:user_id]
		@user = current_user
		puts "*************************************************" + params.inspect
		post = Post.create(user_id:(params[:user_id]), message:(params[:message]))
		redirect '/'
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

get '/users/new' do 
	erb :signup
end

post '/users/new' do
	user = User.create(
		fname:(params[:fname]),
		lname:(params[:lname]),
		email:(params[:email]),
		password:(params[:password]))
	session[:user_id] = user.id
	flash[:notice] = "You're signed in!"
	redirect '/posts'
end

