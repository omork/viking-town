Dir.glob(File.join(Rails.root, 'app/models/buildings/*.rb')).each { |f| require f }