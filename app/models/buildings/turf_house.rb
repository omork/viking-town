require 'building'

class TurfHouse < Building
  Building::TASKS.merge!("TurfHouse" => %w(hay))
  KEY = "th"

  def do_task(task, times = 1)
    if task.eql?('hay')
      self.village.increment_resources("hay", 1)
      self.village.increment_resources("straw", 3)
      self.village.village_resources.save!
    end
  end
end