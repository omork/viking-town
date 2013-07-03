class Fjord < ActiveRecord::Base
  belongs_to :user
  
  belongs_to :nation
  attr_readonly :nation_id
  
  has_many :ships
  has_many :vikings
  has_many :villages
  has_many :villagers, :through => :villages
  has_many :buildings, :through => :villages
  
  validates :user, :presence => true, :on => :update
  validates :nation, :presence => true
  
  # will_paginate
  self.per_page = 10
  
  attr_accessible :name, :nation_id
end
