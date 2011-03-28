class Building < ActiveRecord::Base
  has_many :villagers
  belongs_to :village
  belongs_to :fjord
  
  validates :fjord, :presence => :true
  validates :village, :presence => :true
end
