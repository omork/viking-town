class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :token_authenticatable, :encryptable

  attr_protected :email, :password, :password_confirmation, :remember_me
  
  has_many :fjords
  belongs_to :nation
  
  validates :nation, :presence => :true
end
