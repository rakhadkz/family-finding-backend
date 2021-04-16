class Address < ApplicationRecord

  def get_lat_long
    {
      "Latitude" => lat,
      "Longitude" => long
    }
  end
end
