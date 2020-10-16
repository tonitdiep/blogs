class User < ActiveRecord::Base
    has_many :blogs
    has_secure_password 
    validates :username, presence: true 
    validates :username, uniqueness: true
    validates :password,  presence: true 
end

#a User has many blogs with those data
#here can we add stuff that validates the data's thru has_secure_password
#validates the uniqueness and presence of emails


