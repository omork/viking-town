require 'building'

class Village < ActiveRecord::Base
  WIDTH = 9 * 40
  HEIGHT = 3 * 20
  
  has_many :villagers
  has_many :buildings
  belongs_to :fjord
  
  has_one :village_resources
  delegate :resources, :to => :village_resources
  
  validates :fjord, :presence => true, :on => :update
  
  after_create :create_first_building
  after_create :create_resource
  
  def create_first_building
    # we don't care about the toplevel constant warning
    silence_warnings do
      rh = Building::RoundHouse.new(:village_id => self.id, :x => (self.width / 2.0).ceil, :y => (self.height / 2.0).ceil)
      rh.save!
      self.buildings << rh
    end
  end
  
  def building_at(x,y)
    self.buildings.select { |b| b.x == x && b.y == y }.first
  end
  
  def building_types ; self.buildings.collect(&:type) ; end
  
  def create_resource ; self.create_village_resources ; end
end
