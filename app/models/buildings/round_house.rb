require 'building.rb'

# reopen Building so that:
# ruby-1.9.2-p180 :004 > v.buildings << Building.new(:x => 1, :y => 2, :type => "RoundHouse")
# => false 
# will validate without having to instantiate the subclass directly
# TODO: swtich to validation stub in base class instead of this goofy duck-punching

class Building < ActiveRecord::Base
  validates_each :type do |model, attr, value|
    if "RoundHouse".eql?(value) && 
      (model.new_record? || model.type_changed?) &&
      model.village_id? && 
      model.village.buildings.collect(&:type).include?("RoundHouse")
      model.errors.add(:type, "Cannot have more than one RoundHouse per village")
    end    
  end
end

class RoundHouse < Building  
  after_create :add_local_chief
  
  Building::TASKS.merge!("RoundHouse" => %w(brawl brew))
  
  KEY = "rh"
  
  def add_local_chief
    self.villagers.create!(:title => :chief, :village_id => self.village_id)
  end
  
  def do_task(task, times)
    return self.default_do_task('beer', times) if 'brew' == task
    self.default_do_task(task, times)
  end
end