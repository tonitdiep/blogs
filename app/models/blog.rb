class Blog < ActiveRecord::Base
    belongs_to :user 
end


#a blog belongs to a user storing the data of all the blogs belong to those Users