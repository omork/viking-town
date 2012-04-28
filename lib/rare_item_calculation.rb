module RareItemCalculation
  # Figuring out rare items needs to happen for a lot of classes. Make it a module so I don't have to keep rewriting it.
  def chances ; return { :rare => 100,  :semi_precious => 50,    :common => 3 } ; end
  def quantities ; return { :rare => 0..1, :semi_precious => 0..10, :common => 5..5 } ; end
  def rarities ; return {} ; end

  def assign_rarities(village, times, rare = [], semi_precious = [], common = [])
    results = {} # cache the results so we only do (at worst) rarities.keys.count updates to the village

    # don't allow an infinite calculation. If they've been gone for a month they don't get a giant chunk of resources
    times = [times, 24 * 60 * 60 * 2 / 5].max

    1.upto(times) do
      chances.keys.each do |rarity|
        next unless rarities.has_key?(rarity)
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
end
