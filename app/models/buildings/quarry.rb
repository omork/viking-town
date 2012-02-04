require 'building'
require 'rare_item_calculation'

class Quarry < Building
  include RareItemCalculation

  Building::TASKS.merge!("Quarry" => %w(quary-stone cut-shaft))
  KEY = "q"
  
  def rarities ; return {
    :rare => %w(gold diamond),
    :semi_precious => %w(silver ruby emerald sapphire),
    :common => %w(copper iron tin)
  } ; end
  
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
      
      self.assign_rarities!(self.village, times)
    end
  end
  
end
