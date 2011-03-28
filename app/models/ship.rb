class Ship < ActiveRecord::Base
  has_many :vikings
  belongs_to :fjord

  validates :fjord, :presence => true, :on => :update
end
