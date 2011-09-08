require 'building'

class MeatMongerShop < Building
  MEAT_MONGER_SHOP_TASKS = %w(slaughter-sheep)
  Building::TASKS.merge!("MeatMongerShop" => MEAT_MONGER_SHOP_TASKS)
  KEY = "mms"

  def do_task(task, times = 1)
    if task.eql?("slaughter-sheep") && (self.village.resources['sheep'] || 0) > 0
      self.village.increment_resources("sheep", -1)

      self.village.increment_resources("sheep-horn", 2) if 0 == Kernel.rand(10)

      self.village.increment_resources("leather", 1)
      self.village.increment_resources("meat", 1)
      self.village.increment_resources!("wool", 3)
    end
  end
end
