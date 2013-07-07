class God < ActiveRecord::Base
  attr_accessible :name, :description, :perks
  serialize :perks

  has_many :villages
  has_many :sacrifices

  POSSIBLE_PERKS = [:ferocity, :honor, :virility, :foresight]

  # this is really only needed for setting up gods one time, but where else
  # would I put it?
  def self.load_from_file(filename)
    raw = File.read(filename)
    raw.split("\n").each do |line|
      name, description = line.gsub(/"$/, '').gsub(/^"/, '').strip.split('","')
      God.create!(name: name, description: description,
                  perks: Hash[*POSSIBLE_PERKS.zip([1,2,3,4].shuffle).flatten])
    end
  end
end
