class Address < ApplicationRecord

  def get_lat_long
    {
      "Latitude" => lat,
      "Longitude" => long
    }
  end

  def has_lat_long?
    !lat.nil? && !long.nil?
  end
end
