require './config/environment'
require 'pry'
require 'sinatra/flash'
require 'sinatra'
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV['SESSION_SECRET']
    register Sinatra::Flash
  end

  get "/" do
    erb :welcome
  end

  not_found do 
    redirect to "/blogs"
  end
  
  helpers do 

    def is_logged_in?
      !!current_user
    end
    def current_user 
      @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]

      # @current_user will be assigned in User.find_by_id if there's a session [user_id]
    end
  end

end
