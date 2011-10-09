module RareItemCalculation
  # Figuring out rare items needs to happen for a lot of classes. Make it a module so I don't have to keep rewriting it.
  chances =    { :rare => 100,  :semi_precious => 50,    :common => 3 }
  quantities = { :rare => 0..1, :semi_precious => 0..10, :common => 5..5 }
  
  def assign_rarities(village, times, rare = [], semi_precious = [], common = [])
    1.upto(times) do
      chances.keys.each do |rarity|
        village.increment_resources(self.rarities[rarity], Building::random(quantities[rarity].max) + quantities[rarity].min
      end
    end
  end
  
  def assign_rarities!(village, times, rare = [], semi_precious = [], common = [])
    assign_rarities(village, times, rare, semi_precious, common)
    village.village_resources.save!
  end
end