class Building < ActiveRecord::Base
  class InvalidTask < StandardError ; end
  
  has_many :villagers
  belongs_to :village
  
  validates :village_id, :presence => true, :on => :update
  
  after_initialize :check_task
  
  TASKS = {}
  
  def allocate(task)
    raise InvalidTask.new("#{task} is an invalid task for #{self.type}") unless TASKS[self.type].include?(task.to_s)
    
    self.assigned_at = Time.now
    self.completed_at = Time.now + self.calculate_duration_of(task)
    self.task = task
  end
  
  # default behaviors for subclasses to re-implement
  def calculate_duration_of(task) ; 5 ; end
  def do_task(task)
    # assume that tasks are also resource names and apply them to the village accordingly
    self.village.resources.has_key?(task) ? self.village.village_resources.resources[task] += 1 : self.village.village_resources.resources[task] = 1
    self.village.village_resources.save!
  end
  
  def check_task
    # everytime a building is insantiated, check to see if it's done with it's current task. If it is, do the reward and save itself.
    
    if self.completed_at && Time.now > self.completed_at
      self.do_task(self.task)
      
      self.assigned_at = nil
      self.completed_at = nil
      
      self.save!
    end
  end
end
