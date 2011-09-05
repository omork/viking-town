class Village < ActiveRecord::Base
  has_many :villagers
  has_many :buildings
  belongs_to :fjord
  
  validates :fjord, :presence => true, :on => :update
  
  after_create :create_first_building
  
  def create_first_building
    # we don't care about the toplevel constant warning
    silence_warnings do
      rh = Building::RoundHouse.new(:village_id => self.id)
      rh.save!
      self.buildings << rh
    end
  end
end
