require 'building.rb'

class RoundHouse < Building
  after_create :add_local_chief
  
  Building::TASKS.merge!("RoundHouse" => %w(brawl brew))
  KEY = "rh"
  def add_local_chief
    self.villagers.create!(:title => :chief, :village_id => self.village_id)
  end
  
  def do_task(task, times)
    return self.default_do_task('beer', times) if 'brew' == task
    self.default_do_task(task, times)
  end
end