require 'building'

class TurfHouse < Building
  TURF_HOUSE_TASKS = %w(hay raise-sheep cut-wood)
  Building::TASKS.merge!("TurfHouse" => TURF_HOUSE_TASKS)
  KEY = "th"

  def do_task(task, times = 1)
    if task.eql?('hay')
      self.village.increment_resources("hay", 1)
      self.village.increment_resources!("straw", 3)
    elsif task.eql?('raise-sheep') && 
      (self.village.resources['straw'] || 0) >= 30 && 
      (self.village.resources['hay'] || 0) >= 10
      
      self.village.increment_resources("sheep", 1)
      self.village.increment_resources("straw", -30)
      self.village.increment_resources!("hay", -10)
    elsif task.eql?('cut-wood')
      self.village.increment_resources!('wood', 1)
    end
  end
  
  def calculate_duration_of(task)
    return 50 if task.eql?('raise-sheep')
    return 5
  end
end