module DistanceMatrix
  require 'uri'
  require 'net/http'

  TOKEN = "YRJo46EXNPOSeX67iC4PUS**nSAcwXpxhQ0PC2lXxuDAZ-**"
  EARTH_RADIUS = 6371e3

  def self.calculate(address1, address2)
    calculate_distance(get_lat_long(address1), get_lat_long(address2))
  end

  private
    def self.get_lat_long(address)
      uri = URI("http://address.melissadata.net/V3/WEB/GlobalAddress/doGlobalAddress?id=#{TOKEN}&a1=#{address}&ctry=US&format=JSON")
      res = Net::HTTP.get_response(uri)
      JSON.parse(res.body)["Records"][0]
    end

    def self.calculate_distance(point1, point2)
      lat1 = point1["Latitude"].to_f
      lat2 = point2["Latitude"].to_f
      lon1 = point1["Longitude"].to_f
      lon2 = point2["Longitude"].to_f
      f1 = lat1 * (Math::PI / 180)
      f2 = lat2 * (Math::PI / 180)
      f = (lat2 - lat1) * (Math::PI / 180)
      l = (lon2 - lon1) * (Math::PI / 180)
      a = Math.sin(f / 2) * Math.sin(f / 2) + Math.cos(f1) * Math.cos(f2) * Math.sin(l / 2) * Math.sin(l / 2)
      c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
      EARTH_RADIUS * c
    end
end
