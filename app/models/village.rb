class Village < ActiveRecord::Base
  has_many :villagers
  has_many :buildings
  belongs_to :fjord
  
  validates :fjord, :presence => true, :on => :update
  
  after_create :create_first_building
  
  def create_first_building
    # we don't care about the toplevel constant warning
    silence_warnings do
      self.buildings << Building::RoundHouse.new
    end
  end
end
