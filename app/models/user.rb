class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :token_authenticatable, :encryptable, :encryptor => :sha512
  
  has_many :fjords
  has_many :ships, :through => :fjords
  has_many :vikings, :through => :fjords
  has_many :villages, :through => :fjords, :readonly => false
  belongs_to :nation
  
  validates :nation, :presence => true, :on => :update
  
  # all of the buildings for self
  def buildings(options = {})
    vids = { :village_id => self.village_ids }
    options.has_key?(:conditions) ? options[:conditions].merge!(vids) : options[:conditions] = vids
    Building.find(:all, options)
  end
  
  # exactly one building owned by self
  def building(id, options = {})
    vids = { :village_id => self.village_ids, :id => id }
    options.has_key?(:conditions) ? options[:conditions].merge!(vids) : options[:conditions] = vids
    Building.find(:first, options)
  end
end
