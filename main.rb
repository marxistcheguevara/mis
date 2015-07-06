require 'sinatra'
require 'sinatra/reloader' if development?
require './user'
require 'sinatra/flash'
require 'v8'

enable :sessions

set :public_folder, "assets"

def authorized?
	!session[:user].nil?
end

#dummy pages
#about
#contact

get '/' do
	@title = "Home"
	erb :home
end

get '/about' do
	@title = "About"
	erb :about
end

get '/contact' do
	@title = "Contact"
	erb :contact
end

get '/login' do
	@title = "Log in"
	erb :login, :layout => false
end

get '/profile' do 
	if !authorized?
		redirect to('/login')
	else
		puts "nihil" if @journal.nil?
		
		erb :profile
	end
end

post '/login' do 
	@username = params[:username]
	@password = params[:password]
	
	user = User.first(:username => @username)
	if user.nil? 
		@msg = "No such user"
		redirect to('/login')

	elsif !user.nil? and user.password != @password
		@msg = "Wrong password"
		redirect to('/login') 
	elsif !user.nil? and user.password == @password
		@msg = "Redirecting to administration page"
		
		session[:user] = user

		redirect to('/profile')
	
	else
		@msg = "UNknown problem occured"
		redirect to('/profile')
	end
end

get '/logout' do 
	session.clear
	redirect to('/login')
end