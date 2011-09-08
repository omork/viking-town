require 'building'

class RoundHouse < Building  
  Building::TASKS.merge!("RoundHouse" => %w(brawl brew))
  KEY = "rh"
  
  after_create :add_local_chief

  def subclass_validations
    # check for duplicate RoundHouses
    self.ensure_exactly_one_roundhouse_per_village
  end
  
  def ensure_exactly_one_roundhouse_per_village
    value = self.type
    if "RoundHouse".eql?(value) && 
      (self.new_record? || self.type_changed?) &&
      self.village_id? &&
      self.village.buildings_types.include?("RoundHouse")
      self.errors.add(:type, "Cannot have more than one RoundHouse per village")
      return false
    end    
    true
  end
  
  def add_local_chief
    self.villagers.create!(:title => :chief, :village_id => self.village_id)
  end
  
  def do_task(task, times)
    return self.default_do_task('beer', times) if 'brew' == task
    self.default_do_task(task, times)
  end
end