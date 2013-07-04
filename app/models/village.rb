require 'building'

class Village < ActiveRecord::Base
  WIDTH = 9 * 40
  HEIGHT = 3 * 20
  
  has_many :villagers
  has_many :buildings
  belongs_to :fjord
  
  has_one :village_resources
  belongs_to :god
  delegate :resources, :to => :village_resources

  validates :fjord, :presence => true, :on => :update

  after_create  :create_first_building
  after_create  :create_resources
  before_create :assign_god

  attr_accessible :name

  def assign_god
    self.god_id = Random.new.rand(God.first.id..God.last.id)
  end

  def create_first_building
    # hex grid makes this calculation weird
    rh = RoundHouse.new(village_id: self.id,
                        x: (self.width / 2.0).ceil,
                        y: (self.width / 2.0).floor)
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

  def buildings_as_json
    self.buildings.collect { |b| b.attributes.merge(:key => b.key) }.to_json.html_safe
  end
end
