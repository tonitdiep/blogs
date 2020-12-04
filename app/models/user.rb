class User < ActiveRecord::Base
    has_many :blogs
    has_secure_password 
    validates :username, presence: true, uniqueness: true
    # validates :username, uniqueness: true 
end




