class Viking < ActiveRecord::Base
  belongs_to :ship
  belongs_to :fjord
  
  validates :fjord, :presence => true, :on => :update
end
