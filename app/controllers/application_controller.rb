require './config/environment'
require 'pry'
require 'sinatra/flash'
require 'sinatra'
class ApplicationController < Sinatra::Base
#webapp controller that knows about to speak sinatra ^
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV['SESSION_SECRET']
    register Sinatra::Flash
  end
#configure block tells the controller where to look to 
# find the views(pages w/ HTML to display text in the browser) and the public directory
  get "/" do
    erb :welcome
  end


  helpers do 

    def is_logged_in?
      !!current_user
    end
    def current_user 
      @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end
  end

end
