require 'pry'
class BlogsController < ApplicationController 
    get '/blogs' do 
        @blogs = Blog.all 
        erb :'/blogs/index'
    end

    get '/blogs/new' do #create #form make new product
        if is_logged_in?
            
            erb :'/blogs/new'
        else
            redirect '/login'
        end
    end


# => #<ActiveRecord::Relation [#<Blog id: 1, title: "how to code", content: "use binding.pry", user_id: "1">, #<Blog id: 2, title: "gardening basil", content: "use binding.pry", user_id: "1">, #<Blog id: 3, title: nil, content: "more on cabbage stew", user_id: "4">, #<Blog id: 4, title: nil, content: "Fall Yams Casserole", user_id: "5">]>
# >> User.all
# D, [2020-10-14T20:52:22.134696 #10909] DEBUG -- :   User Load (49.6ms)  SELECT "users".* FROM "users"
# => #<ActiveRecord::Relation [#<User id: 1, username: "toni", password_digest: "$2a$12$fKkybp6SMuNfyeqCQvsDVeRDGdAbcuUxGR9bjBvF7rL...">, #<User id: 2, username: "Bart", password_digest: "$2a$12$mCM3v6ZE.ntmrNcLy0W51e1eYVSlacEcMA9VH6shzP9...">, #<User id: 3, username: "mint", password_digest: "$2a$12$HYmKrOMx8C.26A67znfkeu9150vzwkg7jgD.iSumUQg...">, #<User id: 4, username: "cabbage", password_digest: "$2a$12$9EgFeaeZ.428dHqaOeEFaeMRPExFCYRox6Zti88x8YA...">, #<User id: 5, username: "basil", password_digest: "$2a$12$4wKbkQnK2uHW58y8sgQkVuG49t0QQ2kzREE.wnXCiyM...">]>
# >> 
    post '/blogs' do #create new blog #show page
        if current_user && params[:title] != "" && params[:content] != ""
            @blog = Blog.create(title: params[:title], content: params[:content], user_id: current_user.id)
            redirect "/blogs/#{@blog.id}"
        else
            redirect "blogs/new"
           
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
            @blog = Blog.find_by_id(params[:id])
            @blog.update(content: params[:content])
            redirect "/blogs/#{@blog.id}"
        else
            redirect "/blogs/#{params[:id]}/edit"    
        end
    end
    delete '/blogs/:id' do 
        if is_logged_in?
            @blog = Blog.find_by_id(params[:id])
                if @blog.user_id == current_user.id
                    @bog.delete
                end
            redirect '/blogs'
        else
            redirect '/login'
        end        
    end
 
    
end