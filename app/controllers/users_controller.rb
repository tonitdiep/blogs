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
           
        user = User.find_by(username: params[:username]) 
            
        if user && user.authenticate(params[:password]) 
            
            session[:user_id] = user.id
            redirect '/blogs'
        else
            flash[:message] = "Invalid Credentials. Please try again."
                
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

    delete '/users' do 
        if is_logged_in?
            user = User.find_by_id(params[:id])
                if user.user_id == current_user.id.to_s
                    user.delete
                end
                redirect '/users'
            else 
                redirect '/login'
            end 
    end

end