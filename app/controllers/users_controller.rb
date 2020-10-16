class UsersController < ApplicationController
    get '/signup' do 
        if is_logged_in? 
            redirect '/blogs'
        else
            erb :'/users/signup'
        end
    end
    post '/signup' do
        #no duplicates username
        @user = User.create(username: params[:username], password: params[:password])
        # binding.pry
        if @user.save 
            # repetitive
            # params[:username]  != "" && params[:password] != "" && User.find_by(username: params[:username]) == nil 
            # @user = User.create(username: params[:username], password: params[:password])
            session[:user_id] = @user.id
            redirect '/blogs'
        else 
            flash[:message] = @user.errors.full_messages
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

        #checks authentication of password to the username for accurracy? validness?
        @user = User.find_by(username: params[:username]) 
   
        #check authenticate password
        if @user && @user.authenticate(params[:password]) 
            session[:user_id] = @user.id
            # redirect '/blogs/index'
            # erb :'/blogs'
            redirect '/blogs'
        else
            flash[:message] = "Invalid Username or Password"
            # redirect '/login'
            erb :'/users/login'
            # erb :'/login'
        end
    end
    get '/logout' do 
        if !!current_user
            session.clear
            erb :'/users/login'
        else
            redirect '/'
        end
  
        # redirect '/login'
    end

end