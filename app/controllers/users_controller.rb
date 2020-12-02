class UsersController < ApplicationController
    get '/signup' do 
        if is_logged_in? 
            redirect '/blogs'
        else
            erb :'/users/signup'
        end
    end
    post '/signup' do

        user = User.new(username: params[:username], password: params[:password])
  
        if user.save 
           
            session[:user_id] = user.id
            redirect '/blogs'
        else 
            flash[:message] = user.errors.full_messages
           
            redirect '/signup'
        end
    end

    get '/login' do   
        if !is_logged_in?
            erb :'/users/login'
        else
            redirect '/blogs'
        end   
    end

    post '/login' do 
            # binding.pry
        #checks authentication of password to the username for accurracy? validness?
        user = User.find_by(username: params[:username]) 
   
        #check authenticate password
        if user && user.authenticate(params[:password]) 
            session[:user_id] = user.id
            # redirect '/blogs/index'
            # erb :'/blogs'
            redirect '/blogs'
        else
            flash[:message] = "Invalid Credentials. Please try again."
            # redirect '/login'
            erb :'/users/login'
            
        end
    end
    get '/logout' do 
        if !!current_user
            session.clear
            erb :'/users/login'
        else
            redirect '/'
        end

    end

end