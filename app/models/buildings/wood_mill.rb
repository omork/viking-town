require 'building'
require 'rare_item_calculation'

class WoodMill < Building
  include RareItemCalculation

  WOODMILL_TASKS = %w(planks)
  Building::TASKS.merge!("WoodMill" => WOODMILL_TASKS)
  KEY = "wm"
  
  # while milling you might come across a tree which has an knee. Makes for good ships.
  def rarities ; return {
    :semi_precious => %w(knees),
  } ; end

  def do_task(task, times = 1)
    if task.eql?('planks') && 
      (self.village.resources['wood'] || 0) >= 2
      
      self.village.increment_resources("planks", 1 * times)
      self.village.increment_resources("pegs", 4 * times)
      
      self.assign_rarities!(self.village, times)
    end
  end
end
