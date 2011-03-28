class Villager < ActiveRecord::Base
  belongs_to :village
  belongs_to :building
  
  validates :building, :presence => true
  validates :village, :presence => true
end
