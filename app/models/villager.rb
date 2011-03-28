class Villager < ActiveRecord::Base
  belongs_to :village
  belongs_to :building

  after_save :assign_villager_to_first_building_if_unassigned
    
  def assign_villager_to_first_building_if_unassigned
    self.village.buildings.first.villagers << self if self.village_id && self.building_id.blank?
  end
end
