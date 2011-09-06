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

  def do_task(task, times = 1)
    # assume that tasks are also resource names and apply them to the village accordingly
    if self.village.resources.has_key?(task)
      self.village.village_resources.resources[task] += 1 * times
    else
      self.village.village_resources.resources[task] = 1 * times
    end

    self.village.village_resources.save!
  end

  def check_task
    # everytime a building is insantiated, check to see if it's done with it's current task. If it is, do the task and save self.

    if self.completed_at && Time.now > self.completed_at
      # how often we've done it (since we passed completed_at) + 1 (since we know we did it once)
      times = ((Time.now - self.completed_at) / self.calculate_duration_of(self.task).to_f).floor + 1
      self.do_task(self.task, times)

      # how much time do we have remaining on the current duration?
      remaining = (Time.now - self.assigned_at) - times * self.calculate_duration_of(self.task)

      self.assigned_at = Time.now
      self.completed_at = self.assigned_at + remaining

      self.save!
    end
  end
end
