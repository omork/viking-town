class Fjord < ActiveRecord::Base
  belongs_to :user
  belongs_to :nation
  has_many :ships
  has_many :vikings
  has_many :villages
  has_many :villagers, :through => :villages
  has_many :buildings, :through => :villages
  
  validates :user, :presence => true, :on => :update
  validates :nation, :presence => true
end
