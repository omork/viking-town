class Viking < ActiveRecord::Base
  belongs_to :ship
  belongs_to :fjord
  
  validates :ship, :presence => :true
  validates :fjord, :presence => :true
end
