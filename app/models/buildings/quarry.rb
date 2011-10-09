require 'building'

class Quarry < Building
  Building::TASKS.merge!("Quarry" => %w(quary-stone cut-shaft))
  KEY = "q"
  
  self.rarities = {
    :rare => %w(gold diamond),
    :semi_precious => %w(silver ruby emerald sapphire),
    :common => %w(copper iron tin)
  }
  
  def subclass_validations
    # check for duplicate quarries
    self.ensure_exactly_one_of("Quarry")
  end
  
  def do_task(task, times)
    if task.eql?('quarry-stone')
      self.default_do_task(task, times)
    else
      # stone is a by-product of all other tasks, but it's less
      self.default_do_task('quarry-stone', Kernel.rand(10) * times)
      self.village.increment_resources('shaft-depth', times)
      
      1.upto(times) do
        self.village.increment_resources(RARE[Kernel.rand(RARE.size)], 1) if 1 == Kernel.rand(100)
        self.village.increment_resources(SEMI_PRECIOUS[Kernel.rand(SEMI_PRECIOUS.size)], Kernel.rand(10)) if 1 == Kernel.rand(10)
      end
      
      self.village.increment_resources!(COMMON[Kernel.rand(COMMON.size)], Kernel.rand(5) * times)
    end
  end
  
end
