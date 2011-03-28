class Ship < ActiveRecord::Base
  has_many :vikings
  belongs_to :fjord
  belongs_to :user
  
  validates :user, :presence => true
  validates :fjord, :presence => true
end
