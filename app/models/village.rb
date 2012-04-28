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
  after_create :create_resources
  
  def create_first_building
    rh = RoundHouse.new(:village_id => self.id, :x => (self.width / 2.0).ceil, :y => (self.height / 2.0).ceil)
    rh.save!
    self.buildings << rh
  end

  def roundhouse
    self.buildings.detect { |b| b.is_a?(RoundHouse) }
  end

  def building_at(x,y)
    self.buildings.select { |b| b.x == x && b.y == y }.first
  end
  
  def building_types ; self.buildings.collect(&:type) ; end
  
  def create_resources ; self.create_village_resources ; end
  
  def increment_resources(resource, amount)
    self.village_resources.resources[resource] = 0 unless self.village_resources.resources.has_key?(resource)
    self.village_resources.resources[resource] += amount
  end
  
  def increment_resources!(resource, amount)
    self.increment_resources(resource, amount)
    self.village_resources.save!
  end
end
