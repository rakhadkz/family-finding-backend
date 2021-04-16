class ZeroTransportation < ArgumentError
  def initialize(msg = "Zero Transportation")
    super(msg)
  end
end
