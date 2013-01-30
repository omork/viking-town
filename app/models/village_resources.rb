class VillageResources < ActiveRecord::Base
  belongs_to :village
  
  serialize :resources
  
  before_create do
    self.resources = {} if self.resources.nil?
  end

  def take!(resource, quantity, times)
    needed = quantity * times
    available = self.resources[resource]
    return 0 if available.nil?
    taken = available - needed
    if taken < 0
      times = self.resources[resource] / quantity
      self.resources[resource] = 0
    else
      self.resources[resource] -= needed
    end
    times
  end
end
