module RareItemCalculation
  # Figuring out rare items needs to happen for a lot of classes. Make it a module so I don't have to keep rewriting it.
  def chances ; return    { :rare => 100,  :semi_precious => 50,    :common => 3 } ; end
  def quantities ; return { :rare => 0..1, :semi_precious => 0..10, :common => 5..5 } ; end
  def rarities ; return   {} ; end

  def assign_rarities(village, times, rare = [], semi_precious = [], common = [])
    results = {}

    chances.keys.each do |rarity|
      next unless rarities.has_key?(rarity)
      0.upto(opportunitities_in(times)) do
        # the sample here ensures that we only add one rarity per iteration (so if you have only 1 "times" you can only get one of each rarity level)
        results[rarities[rarity].sample] = (results[rarity] || 0 ) + Building::random(quantities[rarity].max) + quantities[rarity].min
      end
    end

    results.each do |kv|
      rarity, value = kv
      village.increment_resources(rarity, value)
    end
  end

  def assign_rarities!(village, times, rare = [], semi_precious = [], common = [])
    assign_rarities(village, times, rare, semi_precious, common)
    village.village_resources.save!
  end

private
  # this makes our worst case iteration 29 * chances.keys * number of buildings in village
  def opportunitities_in(times)
    return case times
    when 0..600 then 1
    when 601..1800 then 2
    when 1801..3600 then 3
    when 3601..86400 then times / 3600 + 4
    else 29 end
  end
end
