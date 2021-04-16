module DistanceMatrix
  require 'uri'
  require 'net/http'
  require 'json'

  TOKEN = ENV["MELISSA-TOKEN"]
  EARTH_RADIUS = 6371e3

  def self.calculate(address1, address2)
    calculate_distance(get_lat_long(address1), get_lat_long(address2))
  end

  private
    def self.get_lat_long(address_line)
      address = Address.find_by(address_1: address_line)
      if address
        return address.get_lat_long if address.has_lat_long?
      end
      uri = URI("http://address.melissadata.net/V3/WEB/GlobalAddress/doGlobalAddress?id=#{TOKEN}&a1=#{address_line}&ctry=US&format=JSON")
      res = Net::HTTP.get_response(uri)
      response = JSON.parse(res.body)["Records"][0]
      address&.update(lat: response["Latitude"], long: response["Longitude"])
      return {
        "Latitude" => response["Latitude"] || 0,
        "Longitude" => response["Longitude"] || 0
      }
    end

    def self.calculate_distance(point1, point2)
      lat1 = point1["Latitude"].to_f
      lat2 = point2["Latitude"].to_f
      long1 = point1["Longitude"].to_f
      long2 = point2["Longitude"].to_f
      f1 = lat1 * (Math::PI / 180)
      f2 = lat2 * (Math::PI / 180)
      f = (lat2 - lat1) * (Math::PI / 180)
      l = (long2 - long1) * (Math::PI / 180)
      a = Math.sin(f / 2) * Math.sin(f / 2) + Math.cos(f1) * Math.cos(f2) * Math.sin(l / 2) * Math.sin(l / 2)
      c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
      EARTH_RADIUS * c
    end
end
