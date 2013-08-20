class Fleet < ActiveRecord::Base
  include Resources

  has_many :ships
  belongs_to :user
  belongs_to :village

  before_destroy { |record| record.ships.update_all(fleet_id: nil) }
  
  def docked?
    not self.docked_at.blank?
  end

  def dock_at(village)
    self.village = village
    self.docked_at = Time.now
  end

  def dock_at!(village)
    self.dock_at(village)
    self.save
  end
end
