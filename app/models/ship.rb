class Ship < ActiveRecord::Base
  has_many :vikings
  belongs_to :fleet
  belongs_to :fjord
end
