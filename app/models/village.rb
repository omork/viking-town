class Village < ActiveRecord::Base
  has_many :villagers
  has_many :buildings
  belongs_to :fjord
  
  validates :fjord, :presence => true, :on => :update
  
  after_create :create_first_building
  
  def create_first_building
    self.buildings << RoundHouse.new
  end
end
