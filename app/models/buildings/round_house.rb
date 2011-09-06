require 'building.rb'

class RoundHouse < Building
  after_create :add_local_chief
  
  Building::TASKS.merge!("RoundHouse" => %w(brew brawl))
  def add_local_chief
    self.villagers.create!(:title => :chief, :village_id => self.village_id)
  end
end