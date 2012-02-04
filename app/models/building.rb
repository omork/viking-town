class Building < ActiveRecord::Base
  class InvalidTask < StandardError ; end
  class DuplicateTask < StandardError ; end
  
  SIZE = [40, 20]

  has_many :villagers
  belongs_to :village

  after_validation :subclass_validations
  validates :village_id, :presence => true, :on => :update

  validates_presence_of :type
  validates_numericality_of :x
  validates_numericality_of :y

  before_save :ensure_position_is_immutable
  
  after_initialize :check_task
  
  attr_accessible :type, :x, :y

  TASKS = {}

  # allow subclasses to explode if they try to add a duplicate test (for safety!).
  # I'm not entirely sure this is necessary. Tasks are scoped to classes. The 
  # only real problems would be in which resources they create/consume
  def self.verify_tasks(tasks)
    tasks.each do |task|
      raise DuplicateTask.new if Building::TASKS.values.include?(task)
    end
  end
  
  # let everyone use the same random without repeating it everywhere.
  def self.random(bound) ; Random.rand(bound) ; end
  
  def allocate(task)
    raise InvalidTask.new("type has no tasks") unless TASKS.has_key?(self.type.to_s)
    raise InvalidTask.new("#{task} is an invalid task for #{self.type}") unless TASKS[self.type.to_s].include?(task.to_s)

    self.assigned_at = Time.now
    self.completed_at = Time.now + self.calculate_duration_of(task)
    self.task = task
  end

  # default behaviors for subclasses to re-implement
  def calculate_duration_of(task) ; 5 ; end
  
  # break this out so subclasses can call it
  def default_do_task(task, times)
    self.village.increment_resources!(task, times)
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

  # allow subclasses to perform their own validations without re-opening the class
  # that:
  # ruby-1.9.2-p180 :004 > v.buildings << Building.new(:x => 1, :y => 2, :type => "RoundHouse")
  # => false 
  # will validate without having to instantiate the subclass directly
  def subclass_validations ; true ; end
  
  def ensure_position_is_immutable
    # once a building is positioned, it can't move
    self.x = self.changes['x'].first if self.changes.keys.include?("x") && !self.changes['x'].first.nil?
    self.y = self.changes['y'].first if self.changes.keys.include?("y") && !self.changes['y'].first.nil?
  end
  
  def ensure_exactly_one_of(type)
    value = self.type
    if type.eql?(value) && 
      (self.new_record? || self.type_changed?) &&
      self.village_id? &&
      self.village.buildings_types.include?(type)
      self.errors.add(:type, "Cannot have more than one #{type} per village")
      return false
    end    
    true
  end
end
