class Village < ActiveRecord::Base
  has_many :villagers
  has_many :buildings
  belongs_to :fjord
  
  validates :fjord, :presence => true, :on => :update
end
