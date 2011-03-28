class Nation < ActiveRecord::Base
  has_many :users
  has_many :fjords
end
