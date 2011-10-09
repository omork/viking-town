require 'building'

class WoodMill < Building
  WOODMILL_TASKS = %w(planks)
  Building::TASKS.merge!("WoodMill" => WOODMILL_TASKS)
  KEY = "wm"
  
  RARE = ["knees"]

  def do_task(task, times = 1)
    if task.eql?('planks') && 
      (self.village.resources['wood'] || 0) >= 2
      
      self.village.increment_resources("planks", 1 * times)
      
      # while milling you might come across a tree which has an knee. Makes for good ships.
      1.upto(times) do
          self.village.increment_resources("knees") if Buliding::random(100)
        end
      end
            
      self.village.increment_resources!("pegs", 4 * times)
    end
  end
end