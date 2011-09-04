class Nation < ActiveRecord::Base
  has_many :users
  has_many :fjords
  
  def to_s ; self.name ; end
end
