class Fjord < ActiveRecord::Base
  belongs_to :user
  
  # the nation can't be changed once the fjord is created
  belongs_to :nation, :readonly => true
  attr_readonly :nation_id
  
  has_many :ships
  has_many :vikings
  has_many :villages
  has_many :villagers, :through => :villages
  has_many :buildings, :through => :villages
  
  validates :user, :presence => true, :on => :update
  validates :nation, :presence => true
end
