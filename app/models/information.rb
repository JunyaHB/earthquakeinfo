class Information < ApplicationRecord

  geocoded_by :address
  if Proc.new { |a| a.address_changed? }
    after_validation :geocode
  end

  reverse_geocoded_by :latitude, :longitude
  if Proc.new { |a| a.latitude_changed? or a.longitude_changed? }
    after_validation :reverse_geocode 
  end

end