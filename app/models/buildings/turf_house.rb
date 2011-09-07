class TurfHouse < Building
  Building::TASKS.merge!("TurfHouse" => %w(hay))
  KEY = "th"
end