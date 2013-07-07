class VillageResources < ActiveRecord::Base
  include Resources

  belongs_to :village
  
  # take a set of resources and return the quantity taken.
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

  # try to take all of the specified resources, if it fails, rollback and
  # return false.
  def take_these!(list_of_takes)
    self.with_lock do
      list_of_takes.each do |resource, quantity, times|
        taken = self.take!(resource, quantity, times)
        if taken < times
          self.resources = self.resources_was
          return false
        end
      end

      # this never gets executed because there are no validations or anything
      # else to fail self.save
      unless self.save
        self.resources = self.resources_was
        return false
      end

      return true
    end
  end
end
