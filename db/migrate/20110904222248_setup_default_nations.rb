# encoding: UTF-8
class SetupDefaultNations < ActiveRecord::Migration
  def self.up
    %w(Denmark
    Finland
    Norway
    Sweden
    Iceland
    Åland
    Faroe Islands
    Greenland
    Jämtland
    Lapland
    Scania
    Schleswig-Holstein).each do |name|
      Nation.create!(:name => name)
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration.new("can't go back once nations are created")
  end
end
