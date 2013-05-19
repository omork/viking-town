class VillageResources < ActiveRecord::Base
  belongs_to :village
  
  serialize :resources
  
  before_create do
    self.resources = {} if self.resources.nil?
  end

  def take!(resource, quantity, times)
    available = self.resources[resource]
    return 0 if available.nil?
    needed = quantity * times
    taken = available - needed
    if taken < 0
      times = self.resources[resource] / quantity
      needed = quantity * times
    end

    self.resources[resource] -= needed
    times
  end
end
