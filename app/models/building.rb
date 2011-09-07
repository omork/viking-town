class Building < ActiveRecord::Base
  class InvalidTask < StandardError ; end
  
  SIZE = [40, 20]

  has_many :villagers
  belongs_to :village

  validates :village_id, :presence => true, :on => :update
  validates_numericality_of :x
  validates_numericality_of :y

  before_save :ensure_position_is_immutable
  
  after_initialize :check_task
  
  attr_accessible :type, :x, :y

  TASKS = {}

  def allocate(task)
    raise InvalidTask.new("#{task} is an invalid task for #{self.type}") unless TASKS[self.type].include?(task.to_s)

    self.assigned_at = Time.now
    self.completed_at = Time.now + self.calculate_duration_of(task)
    self.task = task
  end

  # default behaviors for subclasses to re-implement
  def calculate_duration_of(task) ; 5 ; end
  
  # break this out so subclasses can call it
  def default_do_task(task, times)
    if self.village.resources.has_key?(task)
      self.village.village_resources.resources[task] += 1 * times
    else
      self.village.village_resources.resources[task] = 1 * times
    end

    self.village.village_resources.save!
  end
  
  def do_task(task, times = 1)
    # assume that tasks are also resource names and apply them to the village accordingly
    self.default_do_task(task, times)
  end

  def check_task
    # everytime a building is insantiated, check to see if it's done with it's current task. If it is, do the task and save self.

    if self.completed_at && Time.now > self.completed_at
      # how often we've done it (since we passed completed_at) + 1 (since we know we did it once)
      times = ((Time.now - self.completed_at) / self.calculate_duration_of(self.task).to_f).ceil

      # how much time do we have remaining on the current duration?
      remaining = ((self.assigned_at - self.completed_at) % self.calculate_duration_of(self.task))
      
      self.do_task(self.task, times)
      
      self.assigned_at = Time.now
      self.completed_at = self.assigned_at + remaining
      self.save!
    end
  end
  
  def ensure_position_is_immutable
    # once a building is positioned, it can't move
    self.x = self.changes['x'].first if self.changes.keys.include?("x") && !self.changes['x'].first.nil?
    self.y = self.changes['y'].first if self.changes.keys.include?("y") && !self.changes['y'].first.nil?
  end
end
