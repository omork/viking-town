class Building < ActiveRecord::Base
  has_many :villagers
  belongs_to :village
  
  validates :village, :presence => true, :on => :update
end
