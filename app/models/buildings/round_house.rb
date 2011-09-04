class RoundHouse < Building
  after_create :add_local_chief
  
  def add_local_chief
    self.villagers.create!(:title => :chief, :village_id => self.village_id)
  end
end