class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :token_authenticatable, :encryptable, :encryptor => :sha512
  
  has_many :fjords
  has_many :ships, :through => :fjords
  has_many :vikings, :through => :fjords
  belongs_to :nation
  
  validates :nation, :presence => true, :on => :update
end
