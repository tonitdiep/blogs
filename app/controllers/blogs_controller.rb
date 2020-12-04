require 'pry'
class BlogsController < ApplicationController 
    get '/blogs' do 
        @blogs = Blog.all 
        erb :'/blogs/index'
    end

    get '/blogs/new' do #create#form make new product
        if is_logged_in?
            
            erb :'/blogs/new'
        else
            redirect '/login'
        end
    end

    post '/blogs' do #create new blog #show page
        if current_user && params[:title] != "" && params[:content] != ""
            blog = Blog.create(title: params[:title], content: params[:content], user_id: current_user.id)
            redirect "/blogs/#{blog.id}"
        else
            redirect "/blogs/new"
           
        end

    end

    get '/blogs/:id' do #read #show page
        if is_logged_in?
            @blog = Blog.find_by_id(params[:id])
            erb :'/blogs/show' 
            # redirect '/blogs'
        else
            redirect '/login'
        end
    end

    get '/blogs/:id/edit' do 
        if is_logged_in? 
            @blog = Blog.find_by_id(params[:id])
              if @blog.user == current_user
                 erb :'/blogs/edit'  
              else
                redirect '/blogs'
              end
          else 
            redirect '/login'
          end
    end

    patch '/blogs/:id/edit' do 
        if is_logged_in? && params[:blog] != ""
            blog = Blog.find_by_id(params[:id])
            blog.update(title: params[:title])
            blog.update(content: params[:content])
            redirect "/blogs/#{blog.id}"
        else
            redirect "/blogs/#{params[:id]}/edit"    
        end
    end
    delete '/blogs/:id' do 
        if is_logged_in?
            blog = Blog.find_by_id(params[:id])
                if blog.user_id == current_user.id.to_s
                    blog.delete
                end
            redirect '/blogs'
        else
            redirect '/login'
        end        
    end
 
    
end