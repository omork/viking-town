class Sacrifice < ActiveRecord::Base
  include Resources

  belongs_to :god
  belongs_to :village

  before_create :take_resources_from_village
  attr_accessible :god_id, :village_id, :resources

  def take_resources_from_village
    takings = self.resources.map { |key, value| [key, value, 1] }
    self.village.village_resources.take_these!(takings)
  end

  # so this works:
  # > Sacrifice.on_behalf_of(village).these_goods(wood: 10, coal:2)
  # => #<Sacrifice id: nil, resources: {:wood=>10, :coal=>2}, god_id: 1, \
  #        village_id: 1, created_at: nil, updated_at: nil> 
  def self.on_behalf_of(village)
    Sacrifice.new(god_id: village.god_id, village_id: village.id)
  end

  def these_goods(goods)
    unless goods.is_a?(Hash)
      raise ArgumentError.new("Goods must be a hash of resources")
    end

    self.resources = goods
    self
  end
end
