class VillageResources < ActiveRecord::Base
  belongs_to :village
  
  serialize :resources
  
  before_create do
    self.resources = {} if self.resources.nil?
  end
end
