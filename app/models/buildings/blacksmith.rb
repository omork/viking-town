require 'building'
require 'rare_item_calculation'

class Blacksmith < Building
  include RareItemCalculation

  Building::TASKS.merge!("Blacksmith" => %w(smelt wrought sword spear shield axe))
  KEY = "bs"
  
  def rarities ; return Hash.new ; end

  # coal, planks, wrought-iron, copper needed per item:
  def manufacturables ; return {
    'sword'  => [1, 2, 10, 1],
    'spear'  => [1, 3 , 2, 1],
    'shield' => [1, 5, 3, 3],
    'axe'    => [1, 1, 1, 1]
  } ; end

  def take_resources(task, times)
    needs = %w(coal planks wrought-iron copper).zip(self.manufacturables[task])
    times = self.adjust_times_for_needs(needs, times)
    needs.each do |need, quantity| 
      self.village.village_resources.take!(need, quantity, times)
    end
    times
  end

  def manufacture(task, times = 1)
    times = self.take_resources(task, times)
    self.village.increment_resources!(task, times) if times > 0
    times
  end

  def smelt(times)
    times = self.adjust_times_for_needs([['coal', 1], ['iron', 2]], times)
    self.village.village_resources.take!('coal', 1, times)
    self.village.village_resources.take!('iron', 2, times)
    self.village.increment_resources!('iron-ingots', 2 * times)
    times
  end

  def wrought(times)
    times = self.adjust_times_for_needs([['coal', 1], ['iron-ingots', 1]], times)
    self.village.village_resources.take!('coal', 1, times)
    self.village.village_resources.take!('iron-ingots', 1, times)
    self.village.increment_resources!('wrought-iron', times)
    times
  end

  def do_task(task, times = 1)
    times = if self.manufacturables.keys.include?(task)
      # we're manufacturing, figure out if we have enough raw materials
      self.manufacture(task, times)
    else
      self.smelt(times)   if 'smelt' == task
      self.wrought(times) if 'wrought' == task
    end
    times
  end

  def subclass_validations
    # there can be only one blacksmith per village
    self.ensure_exactly_one_of("Blacksmith")
  end

  # blacksmith tasks take a long time
  def calculate_duration_of(task)
    default = super
    case task
      when 'spear'
        default * 2
      when 'sword'
        default * 10
      when 'shield'
        default * 5
      else
        default
    end
  end
end
