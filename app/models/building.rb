class Building < ActiveRecord::Base
  class InvalidTask < StandardError ; end
  
  has_many :villagers
  belongs_to :village, :polymorphic => true
  
  validates :village, :presence => true, :on => :update    
  
  TASKS = {
    "RoundHouse" => %w(brew)
  }
  
  def allocate(task)
    raise InvalidTask.new("#{task} is an invalid task for #{self.type}") unless TASKS[self.type].include?(task.to_s)
    
    self.assigned_at = Time.now
    self.completed_at = Time.now + self.calculate_duration_of(task)
    self.task = task
    self.do_task(task)
  end
  
  # default behaviors for subclasses to re-implement
  def calculate_duration_of(task) ; 5 ; end
  def do_task(task) ; end
end
