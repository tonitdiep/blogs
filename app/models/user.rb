class User < ActiveRecord::Base
    has_many :blogs
    has_secure_password 
    validates :username, presence: true, uniqueness: true
    # validates_length_of :username, in: 5..30 
    
end




